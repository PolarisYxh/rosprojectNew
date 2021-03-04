#!/usr/bin/env python2

# Siemens AG, 2018
# Author: Berkay Alp Cakal (berkay_alp.cakal.ct@siemens.com)
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# <http://www.apache.org/licenses/LICENSE-2.0>.
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import rospy
import numpy
from sensor_msgs.msg import Joy
from geometry_msgs.msg import Twist


def JoyToTwist():
	# initialize node
	rospy.init_node('JoyToTwist', anonymous=True)

	# setup joy topic subscription
	joy_subscriber = rospy.Subscriber("joy", Joy, handleJoyMsg, queue_size=10)

	# spin() simply keeps python from exiting until this node is stopped
	rospy.spin()


def handleJoyMsg(data):
	#### Initialize Speed Parameter
	#   axes  [l.x   l.y   l.z   a.x     a.y    a.z]
	scalers = [0.7,  0.7,  0.7,  -3.14, -3.14, -3.14]
	buttonscalers = [0.3, -0.3, 0.3, -0.3]

	#### Setup Twist Publisher
   	twist_publisher = rospy.Publisher("cmd_vel", Twist)
	msg = Twist()
	flag = False
	if data.buttons[0]==1.0:#接收到button的信息
		msg.linear.x = data.buttons[0] * buttonscalers[0]
		flag = True
	elif data.buttons[1]==1.0:
		msg.linear.x = data.buttons[1] * buttonscalers[1]
		flag = True
	if data.buttons[2]==1.0:
		msg.angular.z = data.buttons[2] * buttonscalers[2]
		flag = True
	elif data.buttons[3]==1.0:
		msg.angular.z = data.buttons[3] * buttonscalers[3]
		flag = True
	#### Start Mapping from Joy to Twist
	if flag == False:#接收到方向盘信息
		if data.axes[1] == -1:
			msg.linear.x = 0.3
		if data.axes[2] == -1:
			msg.linear.x = -0.3
		msg.angular.z = data.axes[0]
	# if len(data.axes) >= 6 :
	# 	msg.angular.x = data.axes[5] * scalers[3]

	# if len(data.axes) >= 5 :
	# 	msg.linear.z = data.axes[4] * scalers[2]

	# if len(data.axes) >= 4 :
	# 	msg.angular.y = data.axes[3] * scalers[4]

	# if len(data.axes) >= 3 :
	# 	msg.linear.y = data.axes[2] * scalers[1]

	# if len(data.axes) >= 2 :
	# 	msg.angular.z = data.axes[1] * scalers[5]

	# if len(data.axes) >= 1 :
	# 	msg.linear.x = data.axes[0] * scalers[0]

	#### Publish msg
	rate = rospy.Rate(100) # 10hz
	rospy.loginfo(msg)
	twist_publisher.publish(msg)
	rate.sleep()

if __name__ == '__main__':
	JoyToTwist()
