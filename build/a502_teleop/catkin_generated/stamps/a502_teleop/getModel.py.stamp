#!/usr/bin/python

import roslib; roslib.load_manifest('package_name')
import rospy
import tf

if __name__ == '__main__':
    rospy.init_node('get_model')
    listener = tf.TransformListener()

    rate = rospy.Rate(10.0)
    while not rospy.is_shutdown():
    try:
        (trans,rot) = listener.lookupTransform('camera_link', 'base_footprint', rospy.Time(0))
        print trans, rot
    except (tf.LookupException, tf.ConnectivityException):
        continue

    rate.sleep()