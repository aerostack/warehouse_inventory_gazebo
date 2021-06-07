# Application: warehouse_inventory_gazebo

This application illustrates how a drone inspects a warehouse with qr boxes. During the mission execution, it is possible to pause and continue the mission execution. While the mission is executing, the drone starts anchoring each and every one of the qr boxes found in the warehouse to a belief memory.

In order to execute the mission, perform the following steps:

- Install Lidar components:

	$ ./lidar_installation

- Execute the script that launches Gazebo for this project:

        $ ./launcher_gazebo.sh

- Wait until the following window is presented:

<img src="https://github.com/aerostack/warehouse_inventory_gazebo/blob/master/doc/launchwarehouse.png" width=600>

- Execute the script that launches the Aerostack components for this project:

        $ ./main_launcher.sh

As a result of this command, a set of windows are presented to monitor the execution of the mission. These windows include:
- Belief viewer
- Lidar mapping

After executing the launcher, you can output the image of the camera annotator with the following command:

	$ rosrun image_view image_view image:=/drone111/bounding_image_raw

In order to start the execution of the mission, execute the following command:

	$ rosservice call /drone111/python_based_mission_interpreter_process/start

The following video illustrates how to launch the project and launch the image of the camera annotator:

[ ![Launch](https://ibb.co/k1v4zsS)](https://youtu.be/ak8_XdOeGqk)

The following video shows the complete execution with the image of the front camera:

[ ![Execution](https://ibb.co/frbwLQN)](https://youtu.be/vERaALMIWm4)


