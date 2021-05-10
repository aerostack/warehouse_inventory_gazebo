#!/bin/bash

DRONE_SWARM_MEMBERS=$1
export AEROSTACK_PROJECT=${AEROSTACK_STACK}/projects/warehouse_inventory_gazebo
MAV_NAME=hummingbird_laser

if [ -z $DRONE_SWARM_MEMBERS ] # Check if NUMID_DRONE is NULL
  then
    #Argument 1 empty
      echo "-Setting Swarm Members = 1"
      DRONE_SWARM_MEMBERS=1
  else
      echo "-Setting DroneSwarm Members = $1"
fi

gnome-terminal  \
    --tab --title "DroneRotorsSimulator" --command "bash -c \"
roslaunch ${AEROSTACK_PROJECT}/configs/gazebo_files/launch/env_mav_rl_navigation.launch project:=${AEROSTACK_PROJECT};
            exec bash\""  &

for (( c=1; c<=$DRONE_SWARM_MEMBERS; c++ )) 
do  
  gnome-terminal  \
  --tab --title "Spawn_mav" --command "bash -c \"
  roslaunch rotors_gazebo mav_swarm_rl_navigation.launch --wait \
    namespace:=$MAV_NAME$c \
    mav_name:=$MAV_NAME \
    log_file:=$MAV_NAME$c \
    x:=6.7 \
    y:=5.5;
  exec bash\""  &
done


