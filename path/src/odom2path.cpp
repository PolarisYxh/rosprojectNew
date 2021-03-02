
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <ros/ros.h>
#include <ros/console.h>
#include <nav_msgs/Path.h>
#include <std_msgs/String.h>

#include <nav_msgs/Odometry.h>


#include <geometry_msgs/Quaternion.h>
#include <geometry_msgs/PoseStamped.h>
#include <tf/transform_broadcaster.h>
#include <tf/tf.h>
#include <fstream>

ros::Publisher  actual_path;
ros::Publisher  plan_path;
ros::Publisher  predict_path;
ros::Subscriber odomSub;
//ros::Subscriber odom_raw_Sub;
//std::ofstream out("/home/yxh/trajectory.txt");
void odomCallback(const nav_msgs::Odometry::ConstPtr& odom)
{
    geometry_msgs::PoseStamped this_pose_stamped;
    this_pose_stamped.pose.position.x = odom->pose.pose.position.x;
    this_pose_stamped.pose.position.y = odom->pose.pose.position.y;
    this_pose_stamped.pose.position.z = odom->pose.pose.position.z;
    this_pose_stamped.pose.orientation = odom->pose.pose.orientation;

    this_pose_stamped.header.stamp = ros::Time::now();
    this_pose_stamped.header.frame_id = "odom";
    sleep(3);
    nav_msgs::Path  path;
    path.poses.push_back(this_pose_stamped);

    path.header.stamp = ros::Time::now();
    path.header.frame_id="odom";

    actual_path.publish(path);




    geometry_msgs::PoseStamped this_pose_stamped1;
    this_pose_stamped1.pose.position.x = odom->pose.pose.position.x+0.1;
    this_pose_stamped1.pose.position.y = odom->pose.pose.position.y;
    this_pose_stamped1.pose.position.z = odom->pose.pose.position.z;
    this_pose_stamped1.pose.orientation = odom->pose.pose.orientation;

    this_pose_stamped1.header.stamp = ros::Time::now();
    this_pose_stamped1.header.frame_id = "odom";
    nav_msgs::Path  path1;
    path1.poses.push_back(this_pose_stamped);

    path1.header.stamp = ros::Time::now();
    path1.header.frame_id="odom";

    plan_path.publish(path1);





    geometry_msgs::PoseStamped this_pose_stamped2;
    this_pose_stamped2.pose.position.x = odom->pose.pose.position.x+0.2;
    this_pose_stamped2.pose.position.y = odom->pose.pose.position.y;
    this_pose_stamped2.pose.position.z = odom->pose.pose.position.z;
    this_pose_stamped2.pose.orientation = odom->pose.pose.orientation;

    this_pose_stamped2.header.stamp = ros::Time::now();
    this_pose_stamped2.header.frame_id = "odom";
    nav_msgs::Path  path2;
    path2.poses.push_back(this_pose_stamped);

    path2.header.stamp = ros::Time::now();
    path2.header.frame_id="odom";

    predict_path.publish(path2);

    printf("path_pub ");
    //out<<this_pose_stamped.pose.position<< this_pose_stamped.pose.orientation<< std::endl;
    printf("odom %.3lf %.3lf\n",odom->pose.pose.position.x,odom->pose.pose.position.y);
 }


int main (int argc, char **argv)
{
    ros::init (argc, argv, "showpath");

    ros::NodeHandle ph;

    actual_path = ph.advertise<nav_msgs::Path>("actual_trajectory",10, true);
    plan_path = ph.advertise<nav_msgs::Path>("plan_trajectory",10, true);
    predict_path = ph.advertise<nav_msgs::Path>("predict_trajectory",10, true);

    odomSub  = ph.subscribe<nav_msgs::Odometry>("/ground_truth/robot_state", 1, odomCallback);


    ros::Rate loop_rate(50);

    while (ros::ok())
    {
        ros::spinOnce();               // check for incoming messages
        loop_rate.sleep();
    }

    return 0;
}

