# 单目相机控制及拍照,相机目前没用模型显示，可以用rviz查看相机图片及运动
roslaunch iqr_4b_bringup fly_cam_mars.launch
rosrun a502_teleop set_link.py
# 502小车
roslaunch iqr_4b_bringup 502_mars.launch    //打开月面仿真环境+502机器车(该车目前含有kinect,laser传感器，后续可以添加)
roslaunch a502_teleop turtlebot3_teleop.launch //打开键盘控制机器车运动程序，wasd控制运动
rosrun a502_teleop joy_to_twist.py //unity方向键盘控制机器车运动