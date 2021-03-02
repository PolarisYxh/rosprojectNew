cmake_minimum_required(VERSION 2.8.3)
project(path)
add_compile_options(-std=c++11)
## Find catkin macros and libraries
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages
# set(BOOST_ROOT "/usr/lib/x86_64-linux-gnu")
find_package(catkin REQUIRED COMPONENTS
	roscpp
	rospy
	std_msgs
	rostime sensor_msgs
	message_filters
	image_transport
	visualization_msgs
	cmake_modules
	tf
	tf_conversions
	eigen_conversions
)
catkin_package(
#  INCLUDE_DIRS include
#  LIBRARIES save_rgbd_from_kinect2
#  CATKIN_DEPENDS roscpp rospy stdmsg
#  DEPENDS system_lib
)
include_directories(include ${catkin_INCLUDE_DIRS})
###########
## Build ##
###########

## Specify additional locations of header files
## Your package locations should be listed before other locations
# include_directories(include)
include_directories(
)

add_executable(odom2path src/odom2path.cpp)
target_link_libraries(odom2path
	${catkin_LIBRARIES}
)

## Mark executables and/or libraries for installation
 install(TARGETS odom2path
#   ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
#   LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
 )
