/**
 *
 * 函数功能：采集iaikinect2输出的彩色图和深度图数据，并以文件的形式进行存储
 *
 *
 * 分隔符为　逗号'，'　　
 * 时间戳单位为秒(s)　精确到小数点后６位(us)
 *
 * maker:crp
 * 2017-5-13
 */

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
#include <termios.h>
using namespace std;
using namespace cv;

Mat rgb;
char successed_flag1 =0;
char successed_flag2 =0;
char successed_flag3 =0;
string topic1_name = "/fly_camera/fly_image_raw"; //topic 名称
string topic2_name = "/ground_truth/fly_camera_state";
string filename_rgbdata="/home/yxh/image/images.txt";
string save_imagedata = "/home/yxh/image/";
bool app_stopped = false;
float param[7];
void sigint_handler(int sig){
	if(sig == SIGINT){
		// ctrl+c退出时执行的代码
		std::cout << "ctrl+c pressed!" << std::endl;
		app_stopped = true;
	}
}
int getch()
{
  static struct termios oldt, newt;
  tcgetattr( STDIN_FILENO, &oldt);           // save old settings
  newt = oldt;
  newt.c_lflag &= ~(ICANON);                 // disable buffering
  tcsetattr( STDIN_FILENO, TCSANOW, &newt);  // apply new settings

  int c = getchar();  // read character (non-blocking)

  tcsetattr( STDIN_FILENO, TCSANOW, &oldt);  // restore old settings
  return c;
}
void  callback_function_color( const sensor_msgs::Image::ConstPtr  image_data);
void  callback_function_pos( const nav_msgs::Odometry::ConstPtr odometry);
int main(int argc,char** argv)
{
    //namedWindow("image color",CV_WINDOW_AUTOSIZE);
    std::cout<<"init start"<<std::endl;
    signal(SIGINT, sigint_handler);
    std::cout<<"init start"<<std::endl;
    ros::init(argc,argv,"rgb_listen");
    std::cout<<"init ok"<<std::endl;
    if(!ros::ok())
        return 0;
    ros::NodeHandle n;
    ros::Subscriber sub1 = n.subscribe(topic1_name,50,callback_function_color);
    ros::Subscriber sub2 = n.subscribe(topic2_name,50,callback_function_pos);
    ros::AsyncSpinner spinner(3); // Use 3 threads
    spinner.start();
    string rgb_str, dep_str;

    struct timeval time_val;
    struct timezone tz;
    double time_stamp;

    ofstream fout_rgb(filename_rgbdata.c_str());
    if(!fout_rgb)
    {
        cerr<<filename_rgbdata<<" file not exist"<<endl;
    }

    int num1=0;
    while(ros::ok())
    {
        if (app_stopped){
			break;
		}
        int c = getch();   // call your non-blocking input function
        if(successed_flag1&&successed_flag2&&c == 'o')
        {
            double k=0.000001*num1;
                //rgb_str = save_imagedata+"rgb/"+os_rgb.str()+".png";
            rgb_str = save_imagedata+"rgb/"+std::to_string(k)+".png";
            cv::Mat rgbmat;
            cv::cvtColor(rgb, rgbmat, cv::COLOR_RGB2BGR);
            imwrite(rgb_str,rgbmat);

            successed_flag1 = 0;
            successed_flag2 = 0;
            fout_rgb << num1+1 <<" ";
            for(int i=0;i<7;i++)
                fout_rgb<< param[i]<<" ";
            fout_rgb << num1+1 << " "<< std::to_string(k)+".png"<<std::endl;
            cout<<"rgb -- time:  " <<  time_val.tv_sec<<"."<<time_val.tv_usec<<endl;
            num1++;
        }
    }

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
    param[0] = odometry->pose.pose.orientation.w;
    param[1] = odometry->pose.pose.orientation.x;
    param[2] = odometry->pose.pose.orientation.y;
    param[3] = odometry->pose.pose.orientation.z;

    param[4] = odometry->pose.pose.position.x;
    param[5] = odometry->pose.pose.position.y;
    param[6] = odometry->pose.pose.position.z;
    successed_flag2 = true;
}