# Application: warehouse_inventory_gazebo

This application illustrates how a drone inspects a warehouse with qr boxes. During the mission execution, it is possible to pause and continue the mission execution. While the mission is executing, the drone starts anchoring each and every one of the qr boxes found in the warehouse to a belief memory.

In order to execute the mission, perform the following steps:
- Install package Hector_Slam, Move_base and Amcl if not installed yet:
```
$ sudo apt install ros-noetic-hector-slam
$ sudo apt install ros-noetic-move-base
$ sudo apt install ros-noetic-amcl 
```
	
- Execute the script that launches Gazebo for this project:

        $ ./launch_gazebo.sh

- Wait until the following window is presented:

<img src="https://github.com/aerostack/warehouse_inventory_gazebo/blob/v5-libeccio/doc/launch_window.png" width=600>

- Execute the script that launches the Aerostack components for this project:

        $ ./df_main_launcher.sh

As a result of this command, a set of windows are presented to monitor the execution of the mission. These windows include:
- Belief Memory viewer
- Lidar mapping
- Image from camera

In order to start the execution of the mission, execute the following command:

	$ rosservice call /drone1/python_based_mission_interpreter_process/start

The following video illustrates how to launch the project and launch the image of the camera annotator:

[ ![Launch](https://github.com/aerostack/warehouse_inventory_gazebo/blob/v5-libeccio/doc/launch_gazebo2.png)](https://youtu.be/9c6axGrjE30)

The following video shows the complete execution with the image of the front camera:

[ ![Execution](https://github.com/aerostack/warehouse_inventory_gazebo/blob/v5-libeccio/doc/execute_mission.png)](https://youtu.be/ccFlU2Z32rE)


