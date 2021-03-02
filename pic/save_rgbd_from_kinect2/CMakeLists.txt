cmake_minimum_required(VERSION 2.8.3)
project(save_rgbd_from_kinect2)
add_compile_options(-std=c++11)
find_package(OpenCV REQUIRED)
find_package(OpenMP)
find_package(PCL REQUIRED COMPONENTS common io visualization)
## Find catkin macros and libraries
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages
# set(BOOST_ROOT "/usr/lib/x86_64-linux-gnu")
set(Boost_LIBRARIES "/usr/lib/x86_64-linux-gnu")
if(Boost_FOUND)
  MESSAGE( STATUS "Boost_INCLUDE_DIRS = ${Boost_INCLUDE_DIRS}.")
  MESSAGE( STATUS "Boost_LIBRARIES = ${Boost_LIBRARIES}.")
  MESSAGE( STATUS "Boost_LIB_VERSION = ${Boost_LIB_VERSION}.")
else()
  MESSAGE( WARNING "Not found Boost")
endif()

find_package(catkin REQUIRED COMPONENTS
	roscpp
	rospy
	std_msgs
	rostime sensor_msgs
	message_filters
	cv_bridge
	image_transport
	compressed_image_transport
	compressed_depth_image_transport
	visualization_msgs
	color_depth_msg
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

###########
## Build ##
###########

## Specify additional locations of header files
## Your package locations should be listed before other locations
# include_directories(include)
include_directories(
	${catkin_INCLUDE_DIRS}
	${OpenCV_INCLUDE_DIRS}
	${PCL_INCLUDE_DIRS}
	${kinect2_bridge_INCLUDE_DIRS}
)

add_executable(save_rgbd_from_kinect2 src/save_rgbd_from_kinect2.cpp)
target_link_libraries(save_rgbd_from_kinect2
	${catkin_LIBRARIES}
	${OpenCV_LIBRARIES}
	${PCL_LIBRARY}
	${kinect2_bridge_LIBRARIES}
	${PCL_LIBRARIES}
	/usr/lib/x86_64-linux-gnu/libX11.so#opencv多线程
	pthread#opencv多线程
)

add_executable(transfer_rgbd_both src/transfer_rgbd_both.cpp)
target_link_libraries(transfer_rgbd_both
						${catkin_LIBRARIES}
						${OpenCV_LIBRARIES})
add_dependencies(transfer_rgbd_both ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS}   color_depth_msg_gencpp)


add_executable(save_rgbd_from_kinect2_new src/save_rgbd_from_kinect2_new.cpp)
target_link_libraries(save_rgbd_from_kinect2_new
	${catkin_LIBRARIES}
	${OpenCV_LIBRARIES}
	${kinect2_bridge_LIBRARIES}
	${PCL_LIBRARIES}
)

add_executable(save_rgb src/save_rgb.cpp)
target_link_libraries(save_rgb
	${catkin_LIBRARIES}
	${OpenCV_LIBRARIES}
	${kinect2_bridge_LIBRARIES}
)

add_executable(save_rgb_key src/save_rgb_key.cpp)
target_link_libraries(save_rgb_key
	${catkin_LIBRARIES}
	${OpenCV_LIBRARIES}
	${kinect2_bridge_LIBRARIES}
)

add_executable(triProcess src/triProcess.cpp)
target_link_libraries(triProcess
	${catkin_LIBRARIES}
	${OpenCV_LIBRARIES}
	${kinect2_bridge_LIBRARIES}
	${PCL_LIBRARIES}
)
## Mark executables and/or libraries for installation
 install(TARGETS save_rgbd_from_kinect2
#   ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
#   LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
 )
 install(TARGETS save_rgbd_from_kinect2_new
#   ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
#   LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
 )
 install(TARGETS save_rgb
#   ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
#   LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
 )
 install(TARGETS triProcess
#   ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
#   LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
 )
 install(TARGETS save_rgb_key
#   ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
#   LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
 )
## System dependencies are found with CMake's conventions
# find_package(Boost REQUIRED COMPONENTS system)


## Uncomment this if the package has a setup.py. This macro ensures
## modules and global scripts declared therein get installed
## See http://ros.org/doc/api/catkin/html/user_guide/setup_dot_py.html
# catkin_python_setup()

################################################
## Declare ROS messages, services and actions ##
################################################

## To declare and build messages, services or actions from within this
## package, follow these steps:
## * Let MSG_DEP_SET be the set of packages whose message types you use in
##   your messages/services/actions (e.g. std_msgs, actionlib_msgs, ...).
## * In the file package.xml:
##   * add a build_depend tag for "message_generation"
##   * add a build_depend and a run_depend tag for each package in MSG_DEP_SET
##   * If MSG_DEP_SET isn't empty the following dependency has been pulled in
##     but can be declared for certainty nonetheless:
##     * add a run_depend tag for "message_runtime"
## * In this file (CMakeLists.txt):
##   * add "message_generation" and every package in MSG_DEP_SET to
##     find_package(catkin REQUIRED COMPONENTS ...)
##   * add "message_runtime" and every package in MSG_DEP_SET to
##     catkin_package(CATKIN_DEPENDS ...)
##   * uncomment the add_*_files sections below as needed
##     and list every .msg/.srv/.action file to be processed
##   * uncomment the generate_messages entry below
##   * add every package in MSG_DEP_SET to generate_messages(DEPENDENCIES ...)

## Generate messages in the 'msg' folder
# add_message_files(
#   FILES
#   Message1.msg
#   Message2.msg
# )
## Generate services in the 'srv' folder
# add_service_files(
#   FILES
#   Service1.srv
#   Service2.srv
# )

## Generate actions in the 'action' folder
# add_action_files(
#   FILES
#   Action1.action
#   Action2.action
# )

## Generate added messages and services with any dependencies listed here
# generate_messages(
#   DEPENDENCIES
#   std_msgs  # Or other packages containing msgs
# )

################################################
## Declare ROS dynamic reconfigure parameters ##
################################################

## To declare and build dynamic reconfigure parameters within this
## package, follow these steps:
## * In the file package.xml:
##   * add a build_depend and a run_depend tag for "dynamic_reconfigure"
## * In this file (CMakeLists.txt):
##   * add "dynamic_reconfigure" to
##     find_package(catkin REQUIRED COMPONENTS ...)
##   * uncomment the "generate_dynamic_reconfigure_options" section below
##     and list every .cfg file to be processed

## Generate dynamic reconfigure parameters in the 'cfg' folder
# generate_dynamic_reconfigure_options(
#   cfg/DynReconf1.cfg
#   cfg/DynReconf2.cfg
# )

###################################
## catkin specific configuration ##
###################################
## The catkin_package macro generates cmake config files for your package
## Declare things to be passed to dependent projects
## INCLUDE_DIRS: uncomment this if you package contains header files
## LIBRARIES: libraries you create in this project that dependent projects also need
## CATKIN_DEPENDS: catkin_packages dependent projects also need
## DEPENDS: system dependencies of this project that dependent projects also need
