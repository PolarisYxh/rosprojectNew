#!/usr/bin/env python2
import rospy

from gazebo_msgs.srv import *
import tf
import sys, select, os
if os.name == 'nt':
  import msvcrt
else:
  import tty, termios

BURGER_MAX_LIN_VEL = 1.00
BURGER_MAX_ANG_VEL = 2.84

WAFFLE_MAX_LIN_VEL = 0.26
WAFFLE_MAX_ANG_VEL = 1.82

LIN_VEL_STEP_SIZE = 0.2
ANG_VEL_STEP_SIZE = 0.1
msg = """
Control Your link!
---------------------------
Moving around:
        w
   a    s    d
   z    x    c
w/x : increase/decrease x linear velocity
a/d : increase/decrease  y angular velocity
z/c : increase/decrease  z angular velocity
space key, s : force stop
CTRL-C to quit
"""

e = """
Communications Failed
"""

def getKey():
    if os.name == 'nt':
      return msvcrt.getch()

    tty.setraw(sys.stdin.fileno())
    rlist, _, _ = select.select([sys.stdin], [], [], 0.1)
    if rlist:
        key = sys.stdin.read(1)
    else:
        key = ''

    termios.tcsetattr(sys.stdin, termios.TCSADRAIN, settings)
    return key

def vels(target_linear_vel, target_angular_vel):
    return "currently:\tlinear vel %s\t angular vel %s " % (target_linear_vel,target_angular_vel)

def makeSimpleProfile(output, input, slop):
    if input > output:
        output = min( input, output + slop )
    elif input < output:
        output = max( input, output - slop )
    else:
        output = input

    return output

def constrain(input, low, high):
    if input < low:
      input = low
    elif input > high:
      input = high
    else:
      input = input

    return input

def checkLinearLimitVelocity(vel):
    # if turtlebot3_model == "burger":
    #   vel = constrain(vel, -BURGER_MAX_LIN_VEL, BURGER_MAX_LIN_VEL)
    # elif turtlebot3_model == "waffle" or turtlebot3_model == "waffle_pi":
    #   vel = constrain(vel, -WAFFLE_MAX_LIN_VEL, WAFFLE_MAX_LIN_VEL)
    # else:
    #   vel = constrain(vel, -BURGER_MAX_LIN_VEL, BURGER_MAX_LIN_VEL)
    vel = constrain(vel, -BURGER_MAX_LIN_VEL, BURGER_MAX_LIN_VEL)
    return vel

def checkAngularLimitVelocity(vel):
    # if turtlebot3_model == "burger":
    #   vel = constrain(vel, -BURGER_MAX_ANG_VEL, BURGER_MAX_ANG_VEL)
    # elif turtlebot3_model == "waffle" or turtlebot3_model == "waffle_pi":
    #   vel = constrain(vel, -WAFFLE_MAX_ANG_VEL, WAFFLE_MAX_ANG_VEL)
    # else:
    #   vel = constrain(vel, -BURGER_MAX_ANG_VEL, BURGER_MAX_ANG_VEL)
    vel = constrain(vel, -BURGER_MAX_ANG_VEL, BURGER_MAX_ANG_VEL)
    return vel

if __name__=="__main__":
    if os.name != 'nt':
        settings = termios.tcgetattr(sys.stdin)

    rospy.init_node('set_link_teleop')
    rospy.wait_for_service('/gazebo/set_model_state')
    # pub = rospy.Publisher('/gazebo/set_link_state', LinkState, queue_size=10)
    set_state_service = rospy.ServiceProxy('/gazebo/set_model_state', SetModelState)
    objstate = SetModelStateRequest()  # Create an object of type SetModelStateRequest
    state = objstate.model_state
    state.model_name = "fly_camera"
    #turtlebot3_model = rospy.get_param("model", "burger")

    status = 0
    target_linear_vel   = 0.0
    target_z_vel        = 0.0
    target_angular_vel  = 0.0
    control_linear_vel  = 0.0
    control_angular_vel = 0.0
    control_z_vel       = 0.0

    twist = state.twist
    q = tf.transformations.quaternion_from_euler(0, 3.14159/2, 0)
    state.pose.orientation.x = q[0]
    state.pose.orientation.y = q[1]
    state.pose.orientation.z = q[2]
    state.pose.orientation.w = q[3]
    state.pose.position.x = 0
    state.pose.position.y = 0
    state.pose.position.z = 1.5
    try:
        print(msg)
        while(1):
            key = getKey()
            if key == 'w' :
                target_linear_vel = checkLinearLimitVelocity(target_linear_vel + LIN_VEL_STEP_SIZE)
                status = status + 1
                # print(vels(target_linear_vel,target_angular_vel))
            elif key == 'x' :
                target_linear_vel = checkLinearLimitVelocity(target_linear_vel - LIN_VEL_STEP_SIZE)
                status = status + 1
                # print(vels(target_linear_vel,target_angular_vel))
            elif key == 'z' :
                target_z_vel = checkLinearLimitVelocity(target_z_vel + LIN_VEL_STEP_SIZE)
                status = status + 1
                # print(vels(target_z_vel,target_angular_vel))
            elif key == 'c' :
                target_z_vel = checkLinearLimitVelocity(target_z_vel - LIN_VEL_STEP_SIZE)
                status = status + 1
                # print(vels(target_z_vel,target_angular_vel))
            elif key == 'a' :
                target_angular_vel = checkAngularLimitVelocity(target_angular_vel + ANG_VEL_STEP_SIZE)
                status = status + 1
                # print(vels(target_linear_vel,target_angular_vel))
            elif key == 'd' :
                target_angular_vel = checkAngularLimitVelocity(target_angular_vel - ANG_VEL_STEP_SIZE)
                status = status + 1
                # print(vels(target_linear_vel,target_angular_vel))
            elif key == ' ' or key == 's' :
                target_linear_vel   = 0.0
                control_linear_vel  = 0.0
                target_angular_vel  = 0.0
                control_angular_vel = 0.0
                target_z_vel        = 0.0
                # print(vels(target_linear_vel, target_angular_vel))
            elif key == 'p':
                get_state_service = rospy.ServiceProxy('/gazebo/get_model_state', GetModelState)
                model = GetModelStateRequest()
                model.model_name = 'fly_camera'
                objstate1 = get_state_service(model)
                state.pose.position = objstate1.pose.position
                result = set_state_service(objstate)
                print(result)
            else:
                if (key == '\x03'):
                    break
            control_linear_vel = target_linear_vel#makeSimpleProfile(control_linear_vel, target_linear_vel, (LIN_VEL_STEP_SIZE/2.0))
            twist.linear.x = control_linear_vel

            control_angular_vel = target_angular_vel#makeSimpleProfile(control_angular_vel, target_angular_vel, (ANG_VEL_STEP_SIZE/2.0))
            twist.linear.y = control_angular_vel

            control_z_vel = target_z_vel#makeSimpleProfile(control_z_vel, target_z_vel, (LIN_VEL_STEP_SIZE/2.0))
            twist.linear.z = control_z_vel
            print(state)

    except:
        print(e)

    finally:
        twist = state.twist
        twist.linear.x = 0.0; twist.linear.y = 0.0; twist.linear.z = 0.0
        twist.angular.x = 0.0; twist.angular.y = 0.0; twist.angular.z = 0.0
        result = set_state_service(objstate)

    if os.name != 'nt':
        termios.tcsetattr(sys.stdin, termios.TCSADRAIN, settings)

# gazebo_msgs/LinkState
# string link_name
# geometry_msgs/Pose pose
#   geometry_msgs/Point position
#     float64 x
#     float64 y
#     float64 z
#   geometry_msgs/Quaternion orientation
#     float64 x
#     float64 y
#     float64 z
#     float64 w
# geometry_msgs/Twist twist
#   geometry_msgs/Vector3 linear
#     float64 x
#     float64 y
#     float64 z
#   geometry_msgs/Vector3 angular
#     float64 x
#     float64 y
#     float64 z
# string reference_frame
