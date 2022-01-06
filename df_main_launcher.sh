#!/bin/bash

NUMID_DRONE=1
NETWORK_ROSCORE=$1
SESSION=$USER
UAV_MASS=1.75

mv $AEROSTACK_WORKSPACE/develIgnore $AEROSTACK_WORKSPACE/devel
export APPLICATION_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Kill any previous session (-t -> target session, -a -> all other sessions )
tmux kill-session -t $SESSION
tmux kill-session -a

# Create new session  (-2 allows 256 colors in the terminal, -s -> session name, -d -> not attach to the new session)
tmux -2 new-session -d -s $SESSION

# Create one window per roslaunch (-t -> target session , -n -> window name) 
tmux new-window -t $SESSION:1 -n 'viewer + teleop'
tmux send-keys "roslaunch alphanumeric_viewer alphanumeric_viewer.launch --wait \
    drone_id_namespace:=drone$NUMID_DRONE \
    my_stack_directory:=${APPLICATION_PATH}" C-m
            
tmux new-window -t $SESSION:2 -n 'pixhawk interface'
tmux send-keys "roslaunch pixhawk_interface pixhawk_interface.launch \
--wait drone_id_namespace:=drone$NUMID_DRONE acro_mode:=true simulation_mode:=true " C-m

tmux new-window -t $SESSION:3 -n 'Basic Quadrotor Behaviors'
tmux send-keys "roslaunch basic_quadrotor_behaviors basic_quadrotor_behaviors.launch --wait \
  namespace:=drone$NUMID_DRONE" C-m

tmux new-window -t $SESSION:4 -n 'Quadrotor Motion With DF Control'
tmux send-keys "roslaunch quadrotor_motion_with_df_control quadrotor_motion_with_df_control.launch --wait \
    namespace:=drone$NUMID_DRONE \
    uav_mass:=$UAV_MASS" C-m

tmux new-window -t $SESSION:5 -n 'GroundTruth Gazebo'
tmux send-keys "rosrun topic_tools relay /drone${NUMID_DRONE}/mavros/local_position/pose /drone${NUMID_DRONE}/self_localization/pose & \
rosrun topic_tools relay /drone${NUMID_DRONE}/mavros/local_position/velocity_local /drone${NUMID_DRONE}/self_localization/speed" C-m

tmux new-window -t $SESSION:6 -n 'Throttle_Controller'
tmux send-keys "roslaunch thrust2throttle_controller thrust2throttle_controller.launch --wait \
  namespace:=drone$NUMID_DRONE \
  uav_mass:=$UAV_MASS" C-m

tmux new-window -t $SESSION:7 -n 'Python interpreter'
tmux send-keys "roslaunch python_based_mission_interpreter_process python_based_mission_interpreter_process.launch --wait \
  drone_id_namespace:=drone$NUMID_DRONE \
  drone_id_int:=$NUMID_DRONE \
  my_stack_directory:=${APPLICATION_PATH} \
  mission:=mission.py \
  mission_configuration_folder:=${APPLICATION_PATH}/configs/mission" C-m

tmux new-window -t $SESSION:8 -n 'Belief Manager'
tmux send-keys "roslaunch belief_manager_process belief_manager_process.launch --wait \
  drone_id_namespace:=drone$NUMID_DRONE \
  drone_id:=$NUMID_DRONE \
  config_path:=${APPLICATION_PATH}/configs/mission" C-m

tmux new-window -t $SESSION:9 -n 'Belief Updater'
tmux send-keys "roslaunch common_belief_updater_process common_belief_updater_process.launch --wait \
  drone_id_namespace:=drone$NUMID_DRONE \
  drone_id:=$NUMID_DRONE" C-m
  
tmux new-window -t $SESSION:10 -n 'Box Belief Updater'
tmux send-keys "roslaunch inventory_item_belief_updater inventory_item_belief_updater.launch --wait \
  drone_id_namespace:=drone$NUMID_DRONE \
  drone_id:=$NUMID_DRONE" C-m

tmux new-window -t $SESSION:11 -n 'Item Annotator'
tmux send-keys "roslaunch inventory_item_image_annotator inventory_item_image_annotator.launch --wait \
  drone_id_namespace:=drone$NUMID_DRONE \
  drone_id:=$NUMID_DRONE" C-m
  
tmux new-window -t $SESSION:12 -n 'Attention to visual markers'
tmux send-keys "roslaunch attention_to_visual_markers attention_to_visual_markers.launch --wait \
  drone_id_namespace:=drone$NUMID_DRONE \
  interface_sensor_front_camera:=usb_cam/image_raw;
  drone_id:=$NUMID_DRONE" C-m
 
tmux new-window -t $SESSION:13 -n 'Belief memory Viewer'
tmux send-keys "roslaunch belief_memory_viewer belief_memory_viewer.launch  --wait \
  drone_id_namespace:=drone$NUMID_DRONE \
  drone_id:=$NUMID_DRONE" C-m

tmux new-window -t $SESSION:14 -n 'Behavior Coordinator'
tmux send-keys "roslaunch behavior_coordinator behavior_coordinator.launch --wait \
  robot_namespace:=drone$NUMID_DRONE \
  catalog_path:=${APPLICATION_PATH}/configs/mission/behavior_catalog.yaml" C-m
  
tmux new-window -t $SESSION:15 -n 'Hector Slam'
tmux send-keys "roslaunch ${APPLICATION_PATH}/launchers/hector_slam_launchers/hector_slam.launch --wait \
  drone_id_namespace:=drone$NUMID_DRONE \
  drone_id_int:=$NUMID_DRONE" C-m
  
tmux new-window -t $SESSION:16 -n 'Move Base'
tmux send-keys "roslaunch ${APPLICATION_PATH}/launchers/move_base_launcher/move_base.launch --wait \
  drone_id_namespace:=drone$NUMID_DRONE \
  drone_id_int:=$NUMID_DRONE \
  config_path:=${APPLICATION_PATH}/configs/move_base_files" C-m
  
tmux new-window -t $SESSION:17 -n 'Navigation with lidar'
tmux send-keys "roslaunch navigation_with_lidar navigation_with_lidar.launch --wait \
  namespace:=drone$NUMID_DRONE \
  clearance:=0.33" C-m
  
tmux new-window -t $SESSION:18 -n 'Go to'
tmux send-keys "roslaunch go_to go_to.launch --wait \
  namespace:=drone$NUMID_DRONE" C-m

tmux new-window -t $SESSION:19 -n 'rviz'
tmux send-keys "rosrun rviz rviz -d ${APPLICATION_PATH}/configs/drone$NUMID_DRONE/mapping.rviz" C-m

tmux new-window -t $SESSION:20 -n 'image'
tmux send-keys "rqt_image_view /drone1/bounding_image_raw" C-m

tmux attach-session -t $SESSION:1

