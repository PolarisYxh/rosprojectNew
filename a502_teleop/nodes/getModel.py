#!/usr/bin/python

import rospy
import tf
from nav_msgs.msg import Odometry
from geometry_msgs.msg import Pose, Quaternion, Point, TransformStamped
import tf_conversions
import tf2_ros
trans = []
rot = []
global quat
global pos
quat = []
pos = []
def getstate(msg):
    quat = []
    pos = []
    pos.append(msg.pose.pose.position.x)
    pos.append(msg.pose.pose.position.y)
    pos.append(msg.pose.pose.position.z)

    quat.append(msg.pose.pose.orientation.x)
    quat.append(msg.pose.pose.orientation.y)
    quat.append(msg.pose.pose.orientation.z)
    quat.append(msg.pose.pose.orientation.w)
    rot = [-0.343, 0.0, 0.939, 0]
    trans = [-0.502, 0, 0.829]
    r = tf.transformations.quaternion_multiply(quat, rot)

    camMsg = Odometry()
    camMsg.pose.pose = Pose(Point(trans[0]+pos[0],trans[1]+pos[1],trans[2]+pos[2]), Quaternion(*r))
    camMsg.header.frame_id = "map"
    camMsg.child_frame_id = "camera_link"
    pubCamera.publish(camMsg)

    br = tf2_ros.TransformBroadcaster()
    t = TransformStamped()
    t.header.stamp = rospy.Time.now()
    t.header.frame_id = "map"
    t.child_frame_id = 'base_footprint'
    t.transform.translation.x = msg.pose.pose.position.x
    t.transform.translation.y = msg.pose.pose.position.y
    t.transform.translation.z = msg.pose.pose.position.z
    #q = tf_conversions.transformations.quaternion_from_euler(0, 0, 0)
    t.transform.rotation.x = msg.pose.pose.orientation.x
    t.transform.rotation.y = msg.pose.pose.orientation.y
    t.transform.rotation.z = msg.pose.pose.orientation.z
    t.transform.rotation.w = msg.pose.pose.orientation.w
    br.sendTransform(t)

if __name__ == '__main__':
    rospy.init_node('get_model')
    listener = tf.TransformListener()
    state = rospy.Subscriber('/ground_truth/robot_state', Odometry, getstate)
    pubCamera = rospy.Publisher('/ground_truth/camera_state', Odometry, queue_size=10)
    rate = rospy.Rate(10.0)
    while not rospy.is_shutdown():
        pass
        # try:
        #     # (trans, rot) = listener.lookupTransform('base_footprint', '', rospy.Time(0))
        #     # pub_map(trans, rot)
        #     # print(trans, rot)
        # except (tf.LookupException, tf.ConnectivityException):
        #     continue
    rate.sleep()