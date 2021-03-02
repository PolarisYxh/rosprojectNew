#include <iostream>
#include <string>
#include <stdlib.h>
#include <stdio.h>
#include <sstream>
#include <vector>

#include <ros/ros.h>
#include <ros/spinner.h>
#include <sensor_msgs/CameraInfo.h>
#include <sensor_msgs/Image.h>
#include <nav_msgs/Odometry.h>
#include <std_msgs/String.h>

#include <cv_bridge/cv_bridge.h>//将ROS下的sensor_msgs/Image消息类型转化成cv::Mat。
#include <sensor_msgs/image_encodings.h>//头文件sensor_msgs/Image是ROS下的图像的类型，这个头文件中包含对图像进行编码的函数

#include <image_transport/image_transport.h>
#include <image_transport/subscriber_filter.h>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/opencv.hpp>

#include <fstream>

#include <signal.h>

#include "TriProcess.h"
#include <pcl_conversions/pcl_conversions.h>
#include <sensor_msgs/PointCloud2.h>
#include <math.h>
#include <tf/tf.h>
#include <tf_conversions/tf_eigen.h>
using namespace std;
using namespace cv;
using namespace pcl;
Mat rgb;
char successed_flag1 =0;
char successed_flag2 =0;
string topic1_name = "/fly_camera/fly_image_raw"; //topic 名称
string topic2_name = "/ground_truth/fly_camera_state";
bool app_stopped = false;
float param[7];
tf::Quaternion q;
void sigint_handler(int sig){
	if(sig == SIGINT){
		std::cout << "ctrl+c pressed!" << std::endl;
		app_stopped = true;
	}
}
void  callback_function_color( const sensor_msgs::Image::ConstPtr  image_data);
void  callback_function_pos( const nav_msgs::Odometry::ConstPtr odometry);
double dist(float* prev, float* now)
{
    return sqrt(prev[4]-now[4])*(prev[4]-now[4])+(prev[5]-now[5])*(prev[5]-now[5])+(prev[6]-now[6])*(prev[6]-now[6]);
}
int main(int argc,char** argv)
{
    //namedWindow("image color",CV_WINDOW_AUTOSIZE);
    std::cout<<"init start"<<std::endl;
    signal(SIGINT, sigint_handler);
    ros::init(argc,argv,"rgb_listen");
    if(!ros::ok())
        return 0;
    std::cout<<"ros ok"<<std::endl;
    ros::AsyncSpinner spinner(3); // Use 3 threads
    spinner.start();

    ros::NodeHandle n;
    ros::Subscriber sub1 = n.subscribe(topic1_name,50,callback_function_color);
    ros::Subscriber sub2 = n.subscribe(topic2_name,50,callback_function_pos);
    ros::Publisher pointPublisher = n.advertise<sensor_msgs::PointCloud2>("sparse", 2);
    string rgb_str, dep_str;

    struct timeval time_val;
    struct timezone tz;
    double time_stamp;
    std::cout<<"ros ok1"<<std::endl;
    int num1=0;
    Mat K = ( Mat_<double> ( 3,3 ) << 381.36246688113556, 0, 320.5, 0, 381.36246688113556, 240.5, 0, 0, 1 );
    cv::Mat prevMat;
    float prevParam[7];

    Eigen::Matrix3d R1;
    while(ros::ok())
    {
        //std::cout<<"while"<<std::endl;
        if (app_stopped){
			break;
		}
        if(successed_flag1&&successed_flag2)
        {
            //cout<<"get image and cam pos!"<<endl;
            if(num1 == 0)
            {
                cv::Mat rgbmat;
                cv::cvtColor(rgb, rgbmat, cv::COLOR_RGB2BGR);
                prevMat = rgbmat;//前20帧
                for(int i = 0;i<7;i++)
                {
                    prevParam[i] = param[i];
                }
                tf::Matrix3x3 m;
                m.setRotation(q);
                tf::matrixTFToEigen(m, R1);
            }
            else if(dist(prevParam,param)>2)//num1%20 == 0
            {
                cv::Mat rgbmat;//当前图
                std::cout<<"cvtcolor"<<std::endl;
                cv::cvtColor(rgb, rgbmat, cv::COLOR_RGB2BGR);
                std::cout<<"cvtcolor ok"<<std::endl;
                TriProcess tri;
                //-- 读取图像
                vector<KeyPoint> keypoints_1, keypoints_2;
                vector<DMatch> matches;
                // cv::imshow("1",prevMat);
                // cv::imshow("2",rgbmat);
                // cv::waitKey();
                tri.find_feature_matches ( prevMat, rgbmat, keypoints_1, keypoints_2, matches );
                std::cout<<"find "<<matches.size() <<" matches"<<std::endl;
                if(matches.size() <= 30)
                {
                    continue;
                }
                tf::Matrix3x3 m(q);
                Eigen::Matrix3d R2;
                tf::matrixTFToEigen(m, R2);
                // Eigen::Matrix3d R1 = tri.Quaternion2RotationMatrix(prevParam[0], prevParam[1], prevParam[2], prevParam[3]);
                // Eigen::Matrix3d R2 = tri.Quaternion2RotationMatrix(param[0], param[1], param[2], param[3]);
                //Eigen::Matrix3d R  = r2 * r1.inverse();
                //cout << R << endl;
                Eigen::Vector3d t1 = Eigen::Vector3d(prevParam[4], prevParam[5], prevParam[6]);
                Eigen::Vector3d t2 = Eigen::Vector3d(param[4], param[5], param[6]);
                //-- 三角化
                PointCloud<PointXYZRGB>::Ptr cloud(new PointCloud<PointXYZRGB>);
                vector<Point3d> points;
                tri.triangulation( prevMat, rgbmat, keypoints_1, keypoints_2, matches, R1, t1, R2, t2, points, cloud, K );
                prevMat = rgbmat;
                for(int i = 0;i<7;i++)
                {
                    prevParam[i] = param[i];
                }
                R1 = R2;
                sensor_msgs::PointCloud2 output;
                //把点云转化为ros消息
                pcl::toROSMsg(*cloud, output);
                output.header.frame_id = "base_footprint";
                pointPublisher.publish(output);
                ros::Rate loop_rate(10);
            }
            successed_flag1 = 0;
            successed_flag2 = 0;
            num1++;
        }
    }

    // // ctrl+c退出时执行的代码
    // boost::shared_ptr<pcl::visualization::PCLVisualizer> viewer(new pcl::visualization::PCLVisualizer("3D Viewer"));
    // //pcl::visualization::PointCloudColorHandlerGenericField<pcl::PointXYZ> fildColor(cloud, "z");fildColor, // 按照z字段进行渲染

    // viewer->addPointCloud<pcl::PointXYZRGB>(cloud,  "sample cloud");
    // viewer->setPointCloudRenderingProperties(pcl::visualization::PCL_VISUALIZER_POINT_SIZE, 3, "sample cloud"); // 设置点云大小
    // while (!viewer->wasStopped())
    // {
    //     viewer->spinOnce(100);
    //     boost::this_thread::sleep(boost::posix_time::microseconds(100000));
    // }
    ros::waitForShutdown();
    ros::shutdown();
    return 0;
}
void  callback_function_color(const sensor_msgs::Image::ConstPtr  image_data)
{
   cv_bridge::CvImageConstPtr pCvImage;// 声明一个CvImage指针的实例

   pCvImage = cv_bridge::toCvShare(image_data, image_data->encoding);//将ROS消息中的图象信息提取，生成新cv类型的图象，复制给CvImage指针
   pCvImage->image.copyTo(rgb);
   successed_flag1 = 1;
   //cv::waitKey(0);
}
//IMAGE_ID, QW, QX, QY, QZ, TX, TY, TZ, CAMERA_ID, NAME
void callback_function_pos( const nav_msgs::Odometry::ConstPtr odometry)
{
    param[0] = odometry->pose.pose.orientation.x;
    param[1] = odometry->pose.pose.orientation.y;
    param[2] = odometry->pose.pose.orientation.z;
    param[3] = odometry->pose.pose.orientation.w;
    q.setW(param[3]);
    q.setX(param[0]);
    q.setY(param[1]);
    q.setZ(param[2]);
    param[4] = odometry->pose.pose.position.x;
    param[5] = odometry->pose.pose.position.y;
    param[6] = odometry->pose.pose.position.z;
    successed_flag2 = 1;
}