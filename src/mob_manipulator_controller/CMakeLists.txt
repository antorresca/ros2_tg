cmake_minimum_required(VERSION 3.8)
project(mob_manipulator_controller)

set(CMAKE_CXX_STANDARD 17)

find_package(ament_cmake REQUIRED)
find_package(rclcpp REQUIRED)
find_package(sensor_msgs REQUIRED)
find_package(std_msgs REQUIRED)
find_package(geometry_msgs REQUIRED)
find_package(nav_msgs REQUIRED)
find_package(tf2 REQUIRED)
find_package(tf2_ros REQUIRED)
find_package(tf2_geometry_msgs REQUIRED)
find_package(angles REQUIRED)
find_package(mobile_manipulator_msgs REQUIRED)
find_package(Eigen3 REQUIRED)
find_package(DART 6.6.0 REQUIRED COMPONENTS utils-urdf CONFIG)

include_directories(
  include
  ${EIGEN3_INCLUDE_DIRS}
)

add_executable(mob_manipulator_controller
  src/mob_manipulator_controller_node.cpp
  src/Mob_Manipulator_Controller.cpp
  src/Load_model.cpp
  src/Stack_Tasks.cpp
  src/osc_controller/OSC_Controller.cpp
  src/osc_controller/Position/Position_Manipulator.cpp
  src/osc_controller/Position/Position_Mobile_Robot.cpp
  src/osc_controller/Position/Position_Mob_Manipulator.cpp
  src/osc_controller/Orientation/Orientation_Manipulator.cpp
  src/osc_controller/Orientation/Orientation_Mob_Manipulator.cpp
  src/osc_controller/Orientation/Error_functions.cpp
  src/osc_controller/Joint_limits/Repulsive_potentials.cpp
  src/osc_controller/Joint_limits/Intermediate_value.cpp
  src/osc_controller/Joint_limits/Saturation_joint_space.cpp
  src/osc_controller/Whole_Body_Control/Admittance_controller.cpp
)

ament_target_dependencies(mob_manipulator_controller
  rclcpp
  sensor_msgs
  std_msgs
  geometry_msgs
  nav_msgs
  tf2
  tf2_ros
  tf2_geometry_msgs
  angles
  mobile_manipulator_msgs
)

target_link_libraries(mob_manipulator_controller
  dart
  dart-utils-urdf
  
)

install(TARGETS mob_manipulator_controller
  DESTINATION lib/${PROJECT_NAME}
)

install(DIRECTORY config launch
  DESTINATION share/${PROJECT_NAME}
)

ament_package()
