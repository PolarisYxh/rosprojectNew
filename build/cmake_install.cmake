# Install script for directory: /home/yxh/Documents/mars/src

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/yxh/Documents/mars/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  
      if (NOT EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}")
        file(MAKE_DIRECTORY "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}")
      endif()
      if (NOT EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/.catkin")
        file(WRITE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/.catkin" "")
      endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/yxh/Documents/mars/install/_setup_util.py")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/yxh/Documents/mars/install" TYPE PROGRAM FILES "/home/yxh/Documents/mars/build/catkin_generated/installspace/_setup_util.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/yxh/Documents/mars/install/env.sh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/yxh/Documents/mars/install" TYPE PROGRAM FILES "/home/yxh/Documents/mars/build/catkin_generated/installspace/env.sh")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/yxh/Documents/mars/install/setup.bash;/home/yxh/Documents/mars/install/local_setup.bash")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/yxh/Documents/mars/install" TYPE FILE FILES
    "/home/yxh/Documents/mars/build/catkin_generated/installspace/setup.bash"
    "/home/yxh/Documents/mars/build/catkin_generated/installspace/local_setup.bash"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/yxh/Documents/mars/install/setup.sh;/home/yxh/Documents/mars/install/local_setup.sh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/yxh/Documents/mars/install" TYPE FILE FILES
    "/home/yxh/Documents/mars/build/catkin_generated/installspace/setup.sh"
    "/home/yxh/Documents/mars/build/catkin_generated/installspace/local_setup.sh"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/yxh/Documents/mars/install/setup.zsh;/home/yxh/Documents/mars/install/local_setup.zsh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/yxh/Documents/mars/install" TYPE FILE FILES
    "/home/yxh/Documents/mars/build/catkin_generated/installspace/setup.zsh"
    "/home/yxh/Documents/mars/build/catkin_generated/installspace/local_setup.zsh"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/yxh/Documents/mars/install/.rosinstall")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/yxh/Documents/mars/install" TYPE FILE FILES "/home/yxh/Documents/mars/build/catkin_generated/installspace/.rosinstall")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/yxh/Documents/mars/build/gtest/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/iqr_4b_robot-master/iqr_4b_navigation/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/kinova-ros-master/kinova_bringup/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/kinova-ros-master/kinova_control/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/kinova-ros-master/kinova_gazebo/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/universal_robot-melodic-devel/universal_robot/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/universal_robot-melodic-devel/universal_robots/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/universal_robot-melodic-devel/ur_description/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/universal_robot-melodic-devel/ur_e_description/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/universal_robot-melodic-devel/ur_msgs/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/file_server/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/iqr_pan_tilt-master/pan_tilt_bringup/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/iqr_pan_tilt-master/pan_tilt_msg/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/iqr_pan_tilt-master/pan_tilt_driver/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/kinova-ros-master/kinova_msgs/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/pic/kinectv2_msg/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/gazebo_simulation_scene/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/a502_teleop/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/iqr_4b_robot-master/iqr_4b_bringup/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/kinova-ros-master/kinova_driver/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/kinova-ros-master/kinova_demo/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/path/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/pic/save_rgbd_from_kinect2/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/unity_simulation_scene/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/universal_robot-melodic-devel/ur_bringup/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/universal_robot-melodic-devel/ur_driver/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/universal_robot-melodic-devel/ur_e_gazebo/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/universal_robot-melodic-devel/ur_gazebo/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/iqr_4b_robot-master/iqr_4b_description/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/iqr_4b_robot-master/iqr_4b_moveit_config/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/iqr_pan_tilt-master/pan_tilt_description/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/asm_car_asm/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/kinova-ros-master/kinova_description/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/kinova-ros-master/kinova_moveit/robot_configs/j2n6s300_moveit_config/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/kinova-ros-master/kinova_moveit/robot_configs/j2s6s300_moveit_config/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/kinova-ros-master/kinova_moveit/robot_configs/j2s7s300_moveit_config/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/kinova-ros-master/kinova_moveit/robot_configs/m1n6s300_moveit_config/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/kinova-ros-master/kinova_moveit/inverse_kinematics_plugins/ikfast/j2n6s300_ikfast/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/kinova-ros-master/kinova_moveit/inverse_kinematics_plugins/ikfast/j2s6s300_ikfast/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/kinova-ros-master/kinova_moveit/inverse_kinematics_plugins/ikfast/j2s7s300_ikfast/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/kinova-ros-master/kinova_moveit/inverse_kinematics_plugins/ikfast/m1n6s300_ikfast/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/kinova-ros-master/kinova_moveit/kinova_arm_moveit_demo/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/universal_robot-melodic-devel/ur10_e_moveit_config/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/universal_robot-melodic-devel/ur10_moveit_config/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/universal_robot-melodic-devel/ur3_e_moveit_config/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/universal_robot-melodic-devel/ur3_moveit_config/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/universal_robot-melodic-devel/ur5_e_moveit_config/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/universal_robot-melodic-devel/ur5_moveit_config/cmake_install.cmake")
  include("/home/yxh/Documents/mars/build/universal_robot-melodic-devel/ur_kinematics/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/home/yxh/Documents/mars/build/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
