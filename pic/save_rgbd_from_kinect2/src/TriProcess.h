#include <vector>
#include <stdio.h>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/opencv.hpp>
#include <opencv2/features2d/features2d.hpp>
#include <opencv2/calib3d/calib3d.hpp>
#include <Eigen/Dense>
#include <pcl/point_types.h>
#include <pcl/io/ply_io.h>
#include <pcl/visualization/pcl_visualizer.h>
#include <pcl/io/io.h>
#include <tf/tf.h>
using namespace std;
using namespace pcl;
using namespace cv;
class TriProcess
{
public:
    void find_feature_matches (
        const Mat& img_1, const Mat& img_2,
        std::vector<KeyPoint>& keypoints_1,
        std::vector<KeyPoint>& keypoints_2,
        std::vector< DMatch >& matches );

    void pose_estimation_2d2d (
        const std::vector<KeyPoint>& keypoints_1,
        const std::vector<KeyPoint>& keypoints_2,
        const std::vector< DMatch >& matches,
        Mat& R, Mat& t );

    void triangulation (
        Mat pic1, Mat pic2,
        const vector< KeyPoint >& keypoint_1,
        const vector< KeyPoint >& keypoint_2,
        const std::vector< DMatch >& matches,
        const Eigen::Matrix3d& R1, const Eigen::Vector3d& t1,
        const Eigen::Matrix3d& R2, const Eigen::Vector3d& t2,
        vector< Point3d >& points, PointCloud<PointXYZRGB>::Ptr cld, Mat K
    );

    // 像素坐标转相机归一化坐标
    Point2f pixel2cam( const Point2d& p, const Mat& K );
    Eigen::Matrix3d Quaternion2RotationMatrix(const double x,const double y,const double z,const double w);
};

void TriProcess::find_feature_matches( const Mat& img_1, const Mat& img_2,
                            std::vector<KeyPoint>& keypoints_1,
                            std::vector<KeyPoint>& keypoints_2,
                            std::vector< DMatch >& matches )
{
    //-- 初始化
    Mat descriptors_1, descriptors_2;
    // used in OpenCV3
    Ptr<FeatureDetector> detector = ORB::create();
    Ptr<DescriptorExtractor> descriptor = ORB::create();
    // use this if you are in OpenCV2
    // Ptr<FeatureDetector> detector = FeatureDetector::create ( "ORB" );
    // Ptr<DescriptorExtractor> descriptor = DescriptorExtractor::create ( "ORB" );
    Ptr<DescriptorMatcher> matcher  = DescriptorMatcher::create("BruteForce-Hamming");
    //-- 第一步:检测 Oriented FAST 角点位置
    detector->detect ( img_1,keypoints_1 );
    detector->detect ( img_2,keypoints_2 );

    //-- 第二步:根据角点位置计算 BRIEF 描述子
    descriptor->compute ( img_1, keypoints_1, descriptors_1 );
    descriptor->compute ( img_2, keypoints_2, descriptors_2 );

    //-- 第三步:对两幅图像中的BRIEF描述子进行匹配，使用 Hamming 距离
    vector<DMatch> match;
   // BFMatcher matcher ( NORM_HAMMING );
    matcher->match ( descriptors_1, descriptors_2, match );

    //-- 第四步:匹配点对筛选
    double min_dist=10000, max_dist=0;

    //找出所有匹配之间的最小距离和最大距离, 即是最相似的和最不相似的两组点之间的距离
    for ( int i = 0; i < descriptors_1.rows; i++ )
    {
        double dist = match[i].distance;
        if ( dist < min_dist ) min_dist = dist;
        if ( dist > max_dist ) max_dist = dist;
    }

    printf ( "-- Max dist : %f \n", max_dist );
    printf ( "-- Min dist : %f \n", min_dist );

    //当描述子之间的距离大于两倍的最小距离时,即认为匹配有误.但有时候最小距离会非常小,设置一个经验值30作为下限.
    for ( int i = 0; i < descriptors_1.rows; i++ )
    {
        if ( match[i].distance <= max ( 2*min_dist, 30.0 ) )
        {
            matches.push_back ( match[i] );
        }
    }
}

void TriProcess::pose_estimation_2d2d (
    const std::vector<KeyPoint>& keypoints_1,
    const std::vector<KeyPoint>& keypoints_2,
    const std::vector< DMatch >& matches,
    Mat& R, Mat& t )
{
    // 相机内参,TUM Freiburg2
    Mat K = ( Mat_<double> ( 3,3 ) << 520.9, 0, 325.1, 0, 521.0, 249.7, 0, 0, 1 );

    //-- 把匹配点转换为vector<Point2f>的形式
    vector<Point2f> points1;
    vector<Point2f> points2;

    for ( int i = 0; i < ( int ) matches.size(); i++ )
    {
        points1.push_back ( keypoints_1[matches[i].queryIdx].pt );
        points2.push_back ( keypoints_2[matches[i].trainIdx].pt );
    }

    //-- 计算基础矩阵
    Mat fundamental_matrix;
    fundamental_matrix = findFundamentalMat ( points1, points2, CV_FM_8POINT );
    cout<<"fundamental_matrix is "<<endl<< fundamental_matrix<<endl;

    //-- 计算本质矩阵
    Point2d principal_point ( 325.1, 249.7 );				//相机主点, TUM dataset标定值
    int focal_length = 521;						//相机焦距, TUM dataset标定值
    Mat essential_matrix;
    essential_matrix = findEssentialMat ( points1, points2, focal_length, principal_point );
    cout<<"essential_matrix is "<<endl<< essential_matrix<<endl;

    //-- 计算单应矩阵
    Mat homography_matrix;
    homography_matrix = findHomography ( points1, points2, RANSAC, 3 );
    cout<<"homography_matrix is "<<endl<<homography_matrix<<endl;

    //-- 从本质矩阵中恢复旋转和平移信息.
    recoverPose ( essential_matrix, points1, points2, R, t, focal_length, principal_point );
    cout<<"R is "<<endl<<R<<endl;
    cout<<"t is "<<endl<<t<<endl;
}

void TriProcess::triangulation (
    Mat pic1, Mat pic2,
    const vector< KeyPoint >& keypoint_1,
    const vector< KeyPoint >& keypoint_2,
    const std::vector< DMatch >& matches,
    const Eigen::Matrix3d& R1, const Eigen::Vector3d& t1,
    const Eigen::Matrix3d& R2, const Eigen::Vector3d& t2,
    vector< Point3d >& points, PointCloud<PointXYZRGB>::Ptr cld, Mat K)
{
    Mat T1 = (Mat_<float> (3,4) <<
        R1(0,0), R1(0,1), R1(0,2), t1(0,0),
        R1(1,0), R1(1,1), R1(1,2), t1(1,0),
        R1(2,0), R1(2,1), R1(2,2), t1(2,0));
    Mat T2 = (Mat_<float> (3,4) <<
        R2(0,0), R2(0,1), R2(0,2), t2(0,0),
        R2(1,0), R2(1,1), R2(1,2), t2(1,0),
        R2(2,0), R2(2,1), R2(2,2), t2(2,0)
    );
    vector<Point2f> pts_1, pts_2;
    vector<Vec3b> color;
    for ( DMatch m:matches )
    {
        // 将像素坐标转换至相机坐标
        Point2f p1 = keypoint_1[m.queryIdx].pt;
        Point2f p2 = keypoint_2[m.trainIdx].pt;
        pts_1.push_back ( pixel2cam( p1, K) );
        pts_2.push_back ( pixel2cam( p2, K) );
        color.push_back(pic1.at<Vec3b>(p1.x,p1.y));
    }

    Mat pts_4d;
    cv::triangulatePoints( T1, T2, pts_1, pts_2, pts_4d );//pts_4d相对于世界坐标系

    // 转换成非齐次坐标
    for ( int i=0; i<pts_4d.cols; i++ )
    {
        Mat x = pts_4d.col(i);
        x /= x.at<float>(3,0); // 归一化
        Point3d p (
            x.at<float>(2,0),
            x.at<float>(1,0),
            x.at<float>(0,0)
        );
        PointXYZRGB p1;
        p1.x = x.at<float>(2,0);
        p1.y = x.at<float>(1,0);
        p1.z = x.at<float>(0,0),
        p1.r = color[i][2];
        p1.g = color[i][1];
        p1.b = color[i][0];
        cld->insert(cld->begin(), p1);
        points.push_back( p );
    }
}

Point2f TriProcess::pixel2cam ( const Point2d& p, const Mat& K )
{
    return Point2f
    (
        ( p.x - K.at<double>(0,2) ) / K.at<double>(0,0),
        ( p.y - K.at<double>(1,2) ) / K.at<double>(1,1)
    );
}
Eigen::Matrix3d TriProcess::Quaternion2RotationMatrix(const double x,const double y,const double z,const double w)
{
    Eigen::Quaterniond q;
    q.x() = x;
    q.y() = y;
    q.z() = z;
    q.w() = w;

    Eigen::Matrix3d R = q.normalized().toRotationMatrix();
    cout << "Quaternion2RotationMatrix result is:" <<endl;
    cout << "R = " << endl << R << endl<< endl;
    return R;
}
// #include <iostream>
// #include <tf/tf.h>

// int main(){

//   /**< Declaration of quaternion */
//   tf::Quaternion q;
//   q.setW(1);
//   q.setX(0);
//   q.setY(0);
//   q.setZ(0);

//   tf::Quaternion q2(0, 0, 0, 1); // x, y, z, w in order

//   /**< quaternion -> rotation Matrix */
//   tf::Matrix3x3 m(q);

//   tf::Matrix3x3 m2;
//   m2.setRotation(q);

//   /**< rotation Matrix - > quaternion */
//   m.getRotation(q);

//   /**< rotation Matrix -> rpy */
//   double roll, pitch, yaw;
//   m.getRPY(roll, pitch, yaw);

//   /**< rpy -> quaternion */
//   tf::Quaternion q3;
//   q3.setRPY(roll, pitch, yaw);
//   q3.normalize();

//   return 0;
// }