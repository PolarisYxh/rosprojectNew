#!/usr/bin/python

import rospy
import tf
from nav_msgs.msg import Odometry

if __name__ == '__main__':
    rospy.init_node('get_model')
    listener = tf.TransformListener()
    rate = rospy.Rate(10.0)
    while not rospy.is_shutdown():
        try:
            (trans,rot) = listener.lookupTransform('base_footprint', 'camera_link', rospy.Time(0))
            #print trans, rot
        except (tf.LookupException, tf.ConnectivityException):
            continue

    rate.sleep()