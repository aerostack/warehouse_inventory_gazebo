#!/bin/bash

[ ! -f "install_geographiclib_datasets.sh" ] && wget https://raw.githubusercontent.com/mavlink/mavros/master/mavros/scripts/install_geographiclib_datasets.sh && sudo bash ./install_geographiclib_datasets.sh   

sudo apt-get install tmux
sudo apt upgrade libignition-math2
