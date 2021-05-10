if [ -d ${AEROSTACK_STACK}/stack/simulation/quadrotor_gazebo_simulator/rotors_simulator/rotors_description/urdf ];
then
cp configs/gazebo_files/urdf/* ${AEROSTACK_STACK}/stack/simulation/quadrotor_gazebo_simulator/rotors_simulator/rotors_description/urdf/
else
echo "Can not find ${AEROSTACK_STACK}/stack/simulation_system/rotors_simulator/rotors_description/urdf"
echo "Be sure that you have RotorS installed correctly"
fi

if [ -d ${AEROSTACK_STACK}/stack/simulation/quadrotor_gazebo_simulator/rotors_simulator/rotors_gazebo/resource ];
then
cp configs/gazebo_files/resource/* ${AEROSTACK_STACK}/stack/simulation/quadrotor_gazebo_simulator/rotors_simulator/rotors_gazebo/resource/
else
echo "Can not find ${AEROSTACK_STACK}/stack/simulation_system/rotors_simulator/rotors_gazebo/resource"
echo "Be sure that you have RotorS Gazebo installed correctly"
fi

if [ -d ${AEROSTACK_STACK}/stack/simulation/quadrotor_gazebo_simulator/rotors_simulator/rotors_gazebo/launch ];
then
cp configs/gazebo_files/launch/* ${AEROSTACK_STACK}/stack/simulation/quadrotor_gazebo_simulator/rotors_simulator/rotors_gazebo/launch/
else
echo "Can not find ${AEROSTACK_STACK}/stack/simulation_system/rotors_simulator/rotors_gazebo/launch"
echo "Be sure that you have RotorS Gazebo installed correctly"
fi


