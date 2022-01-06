#!/bin/bash

export __NV_PRIME_RENDER_OFFLOAD=1 
export __GLX_VENDOR_LIBRARY_NAME=nvidia

[ -d "/usr/share/gazebo-7" ] && export GAZEBO_RESOURCE_PATH=/usr/share/gazebo-7
[ -d "/usr/share/gazebo-9" ] && export GAZEBO_RESOURCE_PATH=/usr/share/gazebo-9
[ -d "/usr/share/gazebo-11" ] && export GAZEBO_RESOURCE_PATH=/usr/share/gazebo-11

APPLICATION_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
${APPLICATION_PATH}/install_dep.sh

#SIMULATE WITHOUT CAMERA
	#(cd $(rospack find px4) ; make px4_sitl gazebo)
#SIMULATE WITH CAMERA
	(cd $(rospack find px4) ; git submodule update --init --recursive ; DONT_RUN=1 make px4_sitl gazebo)
	export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:$(rospack find px4):$(rospack find px4)/Tools/sitl_gazebo
	export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:${APPLICATION_PATH}/configs/gazebo_files/models
	export GAZEBO_RESOURCE_PATH=$GAZEBO_RESOURCE_PATH:${APPLICATION_PATH}/configs/gazebo_files/models
	source $(rospack find px4)/Tools/setup_gazebo.bash $(rospack find px4) $(rospack find px4)/build/px4_sitl_default
	source $(rospack find px4)/build/px4_sitl_default/build_gazebo/setup.sh
	mv $AEROSTACK_WORKSPACE/devel $AEROSTACK_WORKSPACE/develIgnore
	$(sleep 5 ; mv $AEROSTACK_WORKSPACE/develIgnore $AEROSTACK_WORKSPACE/devel) & roslaunch px4 mavros_posix_sitl.launch world:=${APPLICATION_PATH}/configs/gazebo_files/worlds/qr_world.world vehicle:=iris sdf:=${APPLICATION_PATH}/configs/gazebo_files/models/iris_rplidar/iris_rplidar.sdf respawn_gazebo:=true
	pkill gzserver;pkill gzclient
