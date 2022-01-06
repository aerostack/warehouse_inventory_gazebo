#!/usr/bin/env python3

import mission_execution_control as mxc
import rospy
from aerostack_msgs.msg import ListOfBeliefs
import math
import time
qr_codes = []

points = [
	[1.2, 0, 0.85], [1.2, 9, 0.85] ,[1.2, 9, 1.55], [1.2, 0, 1.55] , [1.2, 0, 2.20], [1.2, 9, 2.20],
[4.5, 9, 2.20], [4.5, 0, 2.20], [4.5, 0, 1.55], [4.5, 9, 1.55], [4.5, 9, 0.85], [4.5, 0, 0.85], [0, 0, 0.85]]

def qr_callback(msg):
	global qr_codes
	index = msg.beliefs.find('code(')
	
	if not index == -1:
		substring = msg.beliefs[index+10:index+12]  

		if not substring.isdigit():
			substring = substring[:-1]

		if qr_codes.count(substring) == 0:
			qr_codes.append(substring)
			print('QR code: {}'.format(substring))


def mission():
	global qr_codes
	print("Starting mission...")
	print("Taking off...")
	mxc.executeTask('TAKE_OFF')
	mxc.startTask('FOLLOW_PATH')
	print("Take off completed...")
	mxc.startTask('CLEAR_OCCUPANCY_GRID')
	j=0
	rospy.Subscriber("/drone111/all_beliefs", ListOfBeliefs, qr_callback)
	uid = 0
	for j, point in enumerate (points, 0):
			retry = 0
			print("Generating path")
			print (str(point))
			if (j == 1 or j == 3 or j == 5 or j == 9 or j == 11):
				mxc.startTask('CLEAR_OCCUPANCY_GRID')
			exit_code = 3	  
			while (retry == 0 or exit_code == 3):
				if (j == 2 or j == 4 or j == 8 or j == 10):
					exit_code = mxc.executeTask('SEND_PATH', path=[points[j]], speed = 0.4, yaw_mode = 0)[1]
					retry = 1
				else:
					traject = mxc.executeTask('GENERATE_PATH', destination=point)
					query = "path(?x,?y)"
					success , unification = mxc.queryBelief(query)
					print (query)
					print (success)
					if success:
						x = str(unification['x'])
						y = str(unification['y'])
						predicate_path = "path(" + x + "," + y + ")"
						mxc.removeBelief(predicate_path)
						predicate_object = "object(" + x + ", path)"
						mxc.removeBelief(predicate_object)
						
						traject = eval(unification['y'])
						print(traject)
						traject = [[b for b in a ]for a in traject]
						i=0
						print ("Moving to"+str(traject[len(traject)-1]))
						
						print ("Following path")
						print ("---------------------------------")
						exit_code = mxc.executeTask('SEND_PATH', path=traject, speed = 0.4, yaw_mode = 0)[1]
						retry = 1
					else:
						print("next iteration")
						mxc.startTask('CLEAR_OCCUPANCY_GRID')
				if (j == 1):
					mxc.startTask('PAY_ATTENTION_TO_QR_CODES')
	mxc.executeTask('LAND')



	#print(qr_codes)
	#mxc.startTask('CLEAR_OCCUPANCY_GRID') 
	print('Finish mission...')
