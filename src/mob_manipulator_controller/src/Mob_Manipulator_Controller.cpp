/*******************************************************************************
* Copyright 2020 Jose Manuel Fajardo
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*******************************************************************************/

#include <mob_manipulator_controller/Mob_Manipulator_Controller.hpp>

namespace mob_manipulator_controller {

using namespace dart::common;
using namespace dart::dynamics;
using namespace dart::math;

using namespace osc_controller;

////////////////////////////////////////////////////////////////////////////////
// Callback function of the joint states
void MobManipulatorController::jointState_CB(const sensor_msgs::msg::JointState::SharedPtr msg){

    for (int ii = 0; ii < (int)msg->position.size(); ii++){
        
        if(msg->name.at(ii)==manipulator_dofs.at(0)){
            q_k(3)        = msg->position.at(ii);
            q_dot_k(3)    = msg->velocity.at(ii);
            tau_joints(3) = msg->effort.at(ii);
        }
        if(msg->name.at(ii)==manipulator_dofs.at(1)){
            q_k(4)        = msg->position.at(ii);
            q_dot_k(4)    = msg->velocity.at(ii);
            tau_joints(4) = msg->effort.at(ii);
        }
        if(msg->name.at(ii)==manipulator_dofs.at(2)){
            q_k(5)        = msg->position.at(ii);
            q_dot_k(5)    = msg->velocity.at(ii);
            tau_joints(5) = msg->effort.at(ii);
        }
        if(msg->name.at(ii)==manipulator_dofs.at(3)){
            q_k(6)        = msg->position.at(ii);
            q_dot_k(6)    = msg->velocity.at(ii);
            tau_joints(6) = msg->effort.at(ii);
        }
        if(msg->name.at(ii)==manipulator_dofs.at(4)){
            q_k(7)        = msg->position.at(ii);
            q_dot_k(7)    = msg->velocity.at(ii);
            tau_joints(7) = msg->effort.at(ii);
        }
        if(msg->name.at(ii)==manipulator_dofs.at(5)){
            q_k(8)        = msg->position.at(ii);
            q_dot_k(8)    = msg->velocity.at(ii);
            tau_joints(8) = msg->effort.at(ii);
        }
    }    
    return;
}

////////////////////////////////////////////////////////////////////////////////
// Callback function of the odometry
void MobManipulatorController::odometry_CB(const nav_msgs::msg::Odometry::SharedPtr msg){

    tf2::Quaternion q;

    q.setX(msg->pose.pose.orientation.x);
    q.setY(msg->pose.pose.orientation.y);
    q.setZ(msg->pose.pose.orientation.z);
    q.setW(msg->pose.pose.orientation.w);

    tf2::Matrix3x3 rot_matrix;
    double roll, pitch, yaw;
    rot_matrix.setRotation(q);
    rot_matrix.getRPY(roll, pitch, yaw);

    q_k(0) = msg->pose.pose.position.x;
    q_k(1) = msg->pose.pose.position.y;
    q_k(2) = yaw;

    q_dot_k(0) = msg->twist.twist.linear.x;
    q_dot_k(1) = msg->twist.twist.linear.y;
    q_dot_k(2) = msg->twist.twist.angular.z;

    return;
}

////////////////////////////////////////////////////////////////////////////////
// Callback function to change the desired pose
void MobManipulatorController::change_DesPose_CB(const mobile_manipulator_msgs::msg::Trajectory::SharedPtr msg){

    transformDesiredPos.transform.translation.x = msg->pose.translation.x;
    transformDesiredPos.transform.translation.y = msg->pose.translation.y;
    transformDesiredPos.transform.translation.z = msg->pose.translation.z;
    transformDesiredPos.transform.rotation.x    = msg->pose.rotation.x;
    transformDesiredPos.transform.rotation.y    = msg->pose.rotation.y;
    transformDesiredPos.transform.rotation.z    = msg->pose.rotation.z;
    transformDesiredPos.transform.rotation.w    = msg->pose.rotation.w;

    mob_man_traj.pose.translation.x = msg->pose.translation.x;
    mob_man_traj.pose.translation.y = msg->pose.translation.y;
    mob_man_traj.pose.translation.z = msg->pose.translation.z;
    mob_man_traj.vel.linear.x       = msg->vel.linear.x;
    mob_man_traj.vel.linear.y       = msg->vel.linear.y;
    mob_man_traj.vel.linear.z       = msg->vel.linear.z;
    mob_man_traj.accel.linear.x     = msg->accel.linear.x;
    mob_man_traj.accel.linear.y     = msg->accel.linear.y;
    mob_man_traj.accel.linear.z     = msg->accel.linear.z;

    mob_man_traj.pose.rotation.x = msg->pose.rotation.x;
    mob_man_traj.pose.rotation.y = msg->pose.rotation.y;
    mob_man_traj.pose.rotation.z = msg->pose.rotation.z;
    mob_man_traj.pose.rotation.w = msg->pose.rotation.w;
    mob_man_traj.vel.angular.x   = msg->vel.angular.x;
    mob_man_traj.vel.angular.y   = msg->vel.angular.y;
    mob_man_traj.vel.angular.z   = msg->vel.angular.z;
    mob_man_traj.accel.angular.x = msg->accel.angular.x;
    mob_man_traj.accel.angular.y = msg->accel.angular.y;
    mob_man_traj.accel.angular.z = msg->accel.angular.z;

    mob_man_traj.joints.mobjoint1 = msg->joints.mobjoint1;
    mob_man_traj.joints.mobjoint2 = msg->joints.mobjoint2;
    mob_man_traj.joints.mobjoint3 = msg->joints.mobjoint3;
    mob_man_traj.joints.joint1    = msg->joints.joint1;
    mob_man_traj.joints.joint2    = msg->joints.joint2;
    mob_man_traj.joints.joint3    = msg->joints.joint3;
    mob_man_traj.joints.joint4    = msg->joints.joint4;
    mob_man_traj.joints.joint5    = msg->joints.joint5;
    mob_man_traj.joints.joint6    = msg->joints.joint6;
}

////////////////////////////////////////////////////////////////////////////////
// Constructor
MobManipulatorController::MobManipulatorController(const rclcpp::NodeOptions& options) :
    rclcpp::Node("mob_manipulator_controller", options),
    frecuency_rate(1000),
    time_previous_sjs(0),
    time_actual_sjs(0.001)
{
    /******************************/
    // Load parameters
    if (!readParameters()) {
        RCLCPP_ERROR(this->get_logger(), "Could not read parameters.");
        rclcpp::shutdown();
        return;
    }

    /******************************/
    // Load DART Object
    loadDARTModel();

    /******************************/
    // Init broadcaster (debe ser antes de initMsgs)
    broadcaster_ = std::make_shared<tf2_ros::TransformBroadcaster>(this);

    /******************************/
    // Init messages
    initMsgs();

    /******************************/
    // Init target variables 
    targetCartPos   = Eigen::Vector3d::Zero(); 
    targetCartVel   = Eigen::Vector3d::Zero(); 
    targetCartAccel = Eigen::Vector3d::Zero(); 

    targetOrientVel   = Eigen::Vector3d::Zero(); 
    targetOrientAccel = Eigen::Vector3d::Zero(); 

    q_desired = Eigen::VectorXd::Zero(robot_dofs);
    tau_ext   = Eigen::VectorXd::Zero(robot_dofs);

    /******************************/
    // Create subscribers
    subs_joint_state_ = this->create_subscription<sensor_msgs::msg::JointState>(
        "/" + robot_name + "/joint_states", 10,
        std::bind(&MobManipulatorController::jointState_CB, this, std::placeholders::_1));

    subs_odometry_ = this->create_subscription<nav_msgs::msg::Odometry>(
        "/" + robot_name + "/" + odometry_topic, 10,
        std::bind(&MobManipulatorController::odometry_CB, this, std::placeholders::_1));

    subs_desired_traj_ = this->create_subscription<mobile_manipulator_msgs::msg::Trajectory>(
        "/" + robot_name + "/desired_traj", 10,
        std::bind(&MobManipulatorController::change_DesPose_CB, this, std::placeholders::_1));

    /******************************/
    // Create publishers
    pub_mobile_platfrm = this->create_publisher<geometry_msgs::msg::Twist>(
        "/" + robot_name + "/commands/velocity", 10);

    pub_joint_efforts = this->create_publisher<std_msgs::msg::Float64MultiArray>(
        "/" + robot_name + "/joint_efforts", 10);

    pub_mob_manipulator_data = this->create_publisher<mobile_manipulator_msgs::msg::MobileManipulator>(
        "/" + robot_name + "/data", 10);

    /******************************/
    // Init time stamps
    time_previous_sjs = this->now().seconds();
    time_actual_sjs   = this->now().seconds();

    /******************************/
    // Create timer for spin loop
    auto period = std::chrono::milliseconds(1000 / frecuency_rate);
    timer_ = this->create_wall_timer(period,
        std::bind(&MobManipulatorController::spin, this));
}

////////////////////////////////////////////////////////////////////////////////
// Destructor
MobManipulatorController::~MobManipulatorController()
{
}

////////////////////////////////////////////////////////////////////////////////
// Function to load parameters
bool MobManipulatorController::readParameters()
{
    this->declare_parameter<std::string>("robot_name", "");
    this->declare_parameter<std::string>("odom_topic", "");
    this->declare_parameter<std::vector<std::string>>("manipulator_dof_names", {});
    this->declare_parameter<bool>("compensate_topdownEffects", false);
    this->declare_parameter<bool>("compensate_nonlinearInJointSpace", false);
    this->declare_parameter<bool>("use_augmented_projections", false);
    this->declare_parameter<int>("singularity_handling", 1);
    this->declare_parameter<int>("joint_limit_avoidance", 0);
    this->declare_parameter<std::vector<std::string>>("models_packages", {});
    this->declare_parameter<std::vector<std::string>>("packages_names", {});
    this->declare_parameter<std::string>("urdf_model_path", "");
    this->declare_parameter<bool>("only_manipulator", false);
    this->declare_parameter<int>("orientation_error_calc", 5);
    this->declare_parameter<double>("point_const_vel_max_lineal", 0.5);
    this->declare_parameter<double>("point_const_vel_max_angular", 1.0);
    this->declare_parameter<double>("Cartesian_position_gains.stiffness.X", 100.0);
    this->declare_parameter<double>("Cartesian_position_gains.stiffness.Y", 100.0);
    this->declare_parameter<double>("Cartesian_position_gains.stiffness.Z", 100.0);
    this->declare_parameter<double>("Cartesian_position_gains.damping_ratios.X", 1.0);
    this->declare_parameter<double>("Cartesian_position_gains.damping_ratios.Y", 1.0);
    this->declare_parameter<double>("Cartesian_position_gains.damping_ratios.Z", 1.0);
    this->declare_parameter<double>("Cartesian_orientation_gains.stiffness.X", 100.0);
    this->declare_parameter<double>("Cartesian_orientation_gains.stiffness.Y", 100.0);
    this->declare_parameter<double>("Cartesian_orientation_gains.stiffness.Z", 100.0);
    this->declare_parameter<double>("Cartesian_orientation_gains.damping_ratios.X", 1.0);
    this->declare_parameter<double>("Cartesian_orientation_gains.damping_ratios.Y", 1.0);
    this->declare_parameter<double>("Cartesian_orientation_gains.damping_ratios.Z", 1.0);
    this->declare_parameter<double>("Joint_tasks_gains.Proportional.Mobile_base", 10.0);
    this->declare_parameter<double>("Joint_tasks_gains.Proportional.Manipulator", 10.0);
    this->declare_parameter<double>("Joint_tasks_gains.Derivative.Mobile_base", 1.0);
    this->declare_parameter<double>("Joint_tasks_gains.Derivative.Manipulator", 1.0);

    this->get_parameter("robot_name",              robot_name);
    this->get_parameter("odom_topic",              odometry_topic);
    this->get_parameter("manipulator_dof_names",   manipulator_dofs);
    this->get_parameter("compensate_topdownEffects",          topdown_);
    this->get_parameter("compensate_nonlinearInJointSpace",   jtspace_);
    this->get_parameter("use_augmented_projections",          augmented_);
    this->get_parameter("singularity_handling",    method_sing_handling);
    this->get_parameter("joint_limit_avoidance",   method_joint_limit_avoidance);
    this->get_parameter("models_packages",         model_packages_paths);
    this->get_parameter("packages_names",          model_packages_names);
    this->get_parameter("urdf_model_path",         urdf_model_path);
    this->get_parameter("only_manipulator",        using_only_manipulator);
    this->get_parameter("orientation_error_calc",  orient_error_calc);
    this->get_parameter("point_const_vel_max_lineal",  point_const_vel_max_lineal);
    this->get_parameter("point_const_vel_max_angular", point_const_vel_max_angular);
    this->get_parameter("Cartesian_position_gains.stiffness.X",    pos_stiff_X);
    this->get_parameter("Cartesian_position_gains.stiffness.Y",    pos_stiff_Y);
    this->get_parameter("Cartesian_position_gains.stiffness.Z",    pos_stiff_Z);
    this->get_parameter("Cartesian_position_gains.damping_ratios.X", pos_damp_X);
    this->get_parameter("Cartesian_position_gains.damping_ratios.Y", pos_damp_Y);
    this->get_parameter("Cartesian_position_gains.damping_ratios.Z", pos_damp_Z);
    this->get_parameter("Cartesian_orientation_gains.stiffness.X",    ori_stiff_X);
    this->get_parameter("Cartesian_orientation_gains.stiffness.Y",    ori_stiff_Y);
    this->get_parameter("Cartesian_orientation_gains.stiffness.Z",    ori_stiff_Z);
    this->get_parameter("Cartesian_orientation_gains.damping_ratios.X", ori_damp_X);
    this->get_parameter("Cartesian_orientation_gains.damping_ratios.Y", ori_damp_Y);
    this->get_parameter("Cartesian_orientation_gains.damping_ratios.Z", ori_damp_Z);
    this->get_parameter("Joint_tasks_gains.Proportional.Mobile_base", mobile_base_p_gain);
    this->get_parameter("Joint_tasks_gains.Proportional.Manipulator", manipulator_p_gain);
    this->get_parameter("Joint_tasks_gains.Derivative.Mobile_base",   mobile_base_d_gain);
    this->get_parameter("Joint_tasks_gains.Derivative.Manipulator",   manipulator_d_gain);

    if (robot_name.empty() || odometry_topic.empty() || manipulator_dofs.empty() ||
        urdf_model_path.empty()) {
        RCLCPP_ERROR(this->get_logger(), "One or more required parameters are empty.");
        return false;
    }

    robot_frame = robot_name + "/mobile_base_link";

    //--- Using only manipulator parameter
    if(using_only_manipulator){
        RCLCPP_INFO(this->get_logger(), "Using only manipulator for tasks");
    }
    else{
        RCLCPP_INFO(this->get_logger(), "Using mobile manipulator for tasks");
    }

    //--- Selection of the orientation error calculation
    switch (orient_error_calc)
    {
        case 1:
            RCLCPP_INFO(this->get_logger(), "Using orient error calculation proposed by Munoz-Osorio");
            osc_controller_.ori_error_mode = 1;
            break;
        case 2:
            RCLCPP_INFO(this->get_logger(), "Using orient error calculation proposed by Caccavale (Angle-Axis)");
            osc_controller_.ori_error_mode = 2;
            break;
        case 3:
            RCLCPP_INFO(this->get_logger(), "Using orient error calculation proposed by Yuan");
            osc_controller_.ori_error_mode = 3;
            break;
        case 4:
            RCLCPP_INFO(this->get_logger(), "Using orient error calculation proposed by Caccavale (Quaternion-1 form)");
            osc_controller_.ori_error_mode = 4;
            break;
        case 5:
            RCLCPP_INFO(this->get_logger(), "Using orient error calculation proposed by Caccavale (Quaternion-2 form)");
            osc_controller_.ori_error_mode = 5;
            break;
        default:
            RCLCPP_INFO(this->get_logger(), "Using orient error calculation proposed by Caccavale (Quaternion-2 form)");
            osc_controller_.ori_error_mode = 5;
            break;
    }

    //--- Top-down effects parameter
    if(topdown_){
        RCLCPP_INFO(this->get_logger(), "Compensating Top down effects");
        osc_controller_.compensate_topdown = true;
    }
    else{
        RCLCPP_INFO(this->get_logger(), "NOT Compensating Top down effects");
        osc_controller_.compensate_topdown = false;
    }

    //--- Compensate non-linear effects in joint space parameter
    if(jtspace_){
        RCLCPP_INFO(this->get_logger(), "Compensating Nonlinear effects in joint space");
        osc_controller_.compensate_jtspace = true;
    }
    else{
        RCLCPP_INFO(this->get_logger(), "NOT Compensating Nonlinear effects in joint space");
        osc_controller_.compensate_jtspace = false;
    }

    //--- Use succesive or augmented projections
    if(augmented_){
        RCLCPP_INFO(this->get_logger(), "Using augmented projections");
        osc_controller_.augmented_projections = true;
    }
    else{
        RCLCPP_INFO(this->get_logger(), "Using succesive projections");
        osc_controller_.augmented_projections = false;
    }

    //--- Method for singularity handling
    switch (method_sing_handling)
    {
        case 0:
            RCLCPP_INFO(this->get_logger(), "Using singularity handling proposed by Khatib");
            osc_controller_.singularity_handling_method = 0;
            break;
        case 1:
            RCLCPP_INFO(this->get_logger(), "Using singularity handling without torque projections");
            osc_controller_.singularity_handling_method = 1;
            break;
        case 2:
            RCLCPP_INFO(this->get_logger(), "Using singularity handling with non-singular torque projections");
            osc_controller_.singularity_handling_method = 2;
            break;
        default:
            RCLCPP_INFO(this->get_logger(), "Using singularity handling without torque projections");
            method_sing_handling = 1;
            osc_controller_.singularity_handling_method = 1;
            break;
    }

    //--- Method for joint limit avoidance
    switch (method_joint_limit_avoidance)
    {
        case -1:
            RCLCPP_INFO(this->get_logger(), "Not handling joint limits");
            osc_controller_.joint_limit_handling_method = -1;
            break;
        case 0:
            RCLCPP_INFO(this->get_logger(), "Using repulsive potentials for joint limit avoidance");
            osc_controller_.joint_limit_handling_method = 0;
            break;
        case 1:
            RCLCPP_INFO(this->get_logger(), "Using intermediate value for joint limit avoidance");
            osc_controller_.joint_limit_handling_method = 1;
            break;
        case 3:
            RCLCPP_INFO(this->get_logger(), "Using SJS (Saturation in joint space) for joint limit avoidance");
            osc_controller_.joint_limit_handling_method = 3;
            break;
        default:
            method_joint_limit_avoidance = 0;
            RCLCPP_INFO(this->get_logger(), "Using repulsive potentials for joint limit avoidance");
            osc_controller_.joint_limit_handling_method = 0;
            break;
    }

    // Update the maximum velocities when using the controller go to point with constant vel
    osc_controller_.max_lineal_vel_  = point_const_vel_max_lineal;
    osc_controller_.max_angular_vel_ = point_const_vel_max_angular;

    // Update cartesian gains
    osc_controller_.changeCartesianPositionGains(   pos_stiff_X, pos_stiff_Y, pos_stiff_Z, pos_damp_X, pos_damp_Y, pos_damp_Z );
    osc_controller_.changeCartesianOrientationGains(ori_stiff_X, ori_stiff_Y, ori_stiff_Z, ori_damp_X, ori_damp_Y, ori_damp_Z );

    // Update joint task gains
    osc_controller_.changeJointTaskGains(mobile_base_p_gain, mobile_base_d_gain, manipulator_p_gain, manipulator_d_gain);

    return true;
}

////////////////////////////////////////////////////////////////////////////////
// Function to initilize the msgs
void MobManipulatorController::initMsgs(){

    /******************************/
    // Init mobile platform msg
    mobile_pltfrm_cmd.linear.x  = 0.0;
    mobile_pltfrm_cmd.linear.y  = 0.0;
    mobile_pltfrm_cmd.linear.z  = 0.0;
    mobile_pltfrm_cmd.angular.x = 0.0;
    mobile_pltfrm_cmd.angular.y = 0.0;
    mobile_pltfrm_cmd.angular.z = 0.0;

    /******************************/
    // Init mobile manipulator header 
    mobile_manipulator_data.header.frame_id = "odom";
    mobile_manipulator_data.header.stamp = this->now();

    /*******************************/
    // Broadcast initial desired pose as original pose
    transformDesiredPos.header.stamp    = this->now();
    transformDesiredPos.header.frame_id = "odom";
    transformDesiredPos.child_frame_id  = robot_name + "/" + "desired_pose";

    Eigen::Vector3d orig_pos = mEndEffector_->getWorldTransform().translation();

    transformDesiredPos.transform.translation.x = orig_pos(0);
    transformDesiredPos.transform.translation.y = orig_pos(1);
    transformDesiredPos.transform.translation.z = orig_pos(2);

    Eigen::Matrix3d R_orig = mEndEffector_->getWorldTransform().rotation();
    Eigen::Quaterniond quat_orig(R_orig);

    transformDesiredPos.transform.rotation.x = quat_orig.x();
    transformDesiredPos.transform.rotation.y = quat_orig.y();
    transformDesiredPos.transform.rotation.z = quat_orig.z();
    transformDesiredPos.transform.rotation.w = quat_orig.w();

    mob_man_traj.pose.translation.x = orig_pos(0);
    mob_man_traj.pose.translation.y = orig_pos(1);
    mob_man_traj.pose.translation.z = orig_pos(2);
    mob_man_traj.vel.linear.x       = 0.0;
    mob_man_traj.vel.linear.y       = 0.0;
    mob_man_traj.vel.linear.z       = 0.0;
    mob_man_traj.accel.linear.x     = 0.0;
    mob_man_traj.accel.linear.y     = 0.0;
    mob_man_traj.accel.linear.z     = 0.0;

    mob_man_traj.pose.rotation.x = quat_orig.x();
    mob_man_traj.pose.rotation.y = quat_orig.y();
    mob_man_traj.pose.rotation.z = quat_orig.z();
    mob_man_traj.pose.rotation.w = quat_orig.w();
    mob_man_traj.vel.angular.x   = 0.0;
    mob_man_traj.vel.angular.y   = 0.0;
    mob_man_traj.vel.angular.z   = 0.0;
    mob_man_traj.accel.angular.x = 0.0;
    mob_man_traj.accel.angular.y = 0.0;
    mob_man_traj.accel.angular.z = 0.0;

    mob_man_traj.joints.mobjoint3 = -10.0;
    mob_man_traj.joints.joint1 = 0.0;
    mob_man_traj.joints.joint2 = 0.0;
    mob_man_traj.joints.joint3 = 0.0;
    mob_man_traj.joints.joint4 = 0.0;
    mob_man_traj.joints.joint5 = 0.0;
    mob_man_traj.joints.joint6 = 0.0;

    broadcaster_->sendTransform(transformDesiredPos);
}

////////////////////////////////////////////////////////////////////////////////
// Spin function (called by timer)
void MobManipulatorController::spin(){

    Eigen::VectorXd current_pos =  q_k;     // Current joint positions
    Eigen::VectorXd current_vel =  q_dot_k; // Current joint velocities

    /******************************/
    //--- Update state of the DART Model
    dart_robotSkeleton->setPositions(current_pos);
    dart_robotSkeleton->setVelocities(current_vel);

    M   = dart_robotSkeleton->getMassMatrix();
    C_k = dart_robotSkeleton->getCoriolisForces();
    g_k = dart_robotSkeleton->getGravityForces();

    /******************************/
    //--- Update target from received data
    updateTarget(current_pos);

    /******************************/
    //--- Init minimum singular values variable to large values
    min_sv_pos = 10.0e3; min_sv_ori = 10.0e3;

    /******************************/
    //--- Calc torque due to tasks in stack of tasks
    calcTorqueDueTasks();

    /******************************/
    //--- Admittance controller
    Eigen::VectorXd mob_base_vel = osc_controller_.admittance_controller(tau_result);

    q_dot_result(0) = mob_base_vel(0);
    q_dot_result(1) = mob_base_vel(1);
    q_dot_result(2) = mob_base_vel(2);

    /******************************/
    // Limit efforts
    for (size_t ii = 0; ii < (size_t)robot_dofs; ii++){

        if(isnan(tau_result(ii))) {
            tau_result(ii) = 0.0;
            std::cout << "Nan in efforts." << std::endl;
        }

        if(ii==3 || ii==6 || ii==7){
            if( abs(tau_result(ii)) > 10.6)
                tau_result(ii) = tau_result(ii) * (10.6/abs(tau_result(ii)));
        }
        else if(ii==4 || ii==5){
            if( abs(tau_result(ii)) > 21.2)
                tau_result(ii) = tau_result(ii) * (21.2/abs(tau_result(ii)));
        }
        else if(ii==8){
            if( abs(tau_result(ii)) > 4.1)
                tau_result(ii) = tau_result(ii) * (4.1/abs(tau_result(ii)));
        }
    }

    /******************************/
    // Limit Velocities
    for (size_t ii = 0; ii < (size_t)robot_dofs; ii++){

        if(isnan(q_dot_result(ii))) {
            q_dot_result(ii) = 0.0;
            std::cout << "Nan in Velocities." << std::endl;
        }

        if(ii<2){
            if( abs(q_dot_result(ii)) > 0.5 )
                q_dot_result(ii) = q_dot_result(ii) * (0.5/abs(q_dot_result(ii)));
        }
        else if(ii==3){
            if( abs(q_dot_result(ii)) > M_PI_2 )
                q_dot_result(ii) = q_dot_result(ii) * (1.75/abs(q_dot_result(ii)));
        }
    }

    /******************************/
    // Message data update
    Eigen::Vector3d current_x = mEndEffector_->getWorldTransform().translation();

    mobile_manipulator_data.position.current_position.x = current_x(0);
    mobile_manipulator_data.position.current_position.y = current_x(1);
    mobile_manipulator_data.position.current_position.z = current_x(2);
    mobile_manipulator_data.position.desired_position.x = targetCartPos(0);
    mobile_manipulator_data.position.desired_position.y = targetCartPos(1);
    mobile_manipulator_data.position.desired_position.z = targetCartPos(2);

    Eigen::Matrix3d eigen_rot_mat = mEndEffector_->getWorldTransform().rotation();
    Eigen::Quaterniond eigen_quat(eigen_rot_mat);

    tf2::Quaternion tf2_quat;
    tf2_quat.setX(eigen_quat.x());
    tf2_quat.setY(eigen_quat.y());
    tf2_quat.setZ(eigen_quat.z());
    tf2_quat.setW(eigen_quat.w());

    tf2::Matrix3x3 rot_mat;
    rot_mat.setRotation(tf2_quat);

    double roll, pitch, yaw;
    rot_mat.getEulerYPR(yaw, pitch, roll);  // ROS2: getEulerYPR en vez de getEulerZYX

    mobile_manipulator_data.orientation.current_orient.roll  = angles::to_degrees(roll);
    mobile_manipulator_data.orientation.current_orient.pitch = angles::to_degrees(pitch);
    mobile_manipulator_data.orientation.current_orient.yaw   = angles::to_degrees(yaw);

    tf2_quat.setX(mob_man_traj.pose.rotation.x);
    tf2_quat.setY(mob_man_traj.pose.rotation.y);
    tf2_quat.setZ(mob_man_traj.pose.rotation.z);
    tf2_quat.setW(mob_man_traj.pose.rotation.w);
    rot_mat.setRotation(tf2_quat);
    rot_mat.getEulerYPR(yaw, pitch, roll);

    mobile_manipulator_data.orientation.desired_orient.roll  = angles::to_degrees(roll);
    mobile_manipulator_data.orientation.desired_orient.pitch = angles::to_degrees(pitch);
    mobile_manipulator_data.orientation.desired_orient.yaw   = angles::to_degrees(yaw);

    mobile_manipulator_data.singular.min_pos_sv = min_sv_pos;
    mobile_manipulator_data.singular.min_ori_sv = min_sv_ori;

    mobile_manipulator_data.torques.torque1 = tau_result(0);
    mobile_manipulator_data.torques.torque2 = tau_result(1);
    mobile_manipulator_data.torques.torque3 = tau_result(2);
    mobile_manipulator_data.torques.torque4 = tau_result(3);
    mobile_manipulator_data.torques.torque5 = tau_result(4);
    mobile_manipulator_data.torques.torque6 = tau_result(5);
    mobile_manipulator_data.torques.torque7 = tau_result(6);
    mobile_manipulator_data.torques.torque8 = tau_result(7);
    mobile_manipulator_data.torques.torque9 = tau_result(8);

    mobile_manipulator_data.joints.actual.mobjoint1  = current_pos(0);
    mobile_manipulator_data.joints.actual.mobjoint2  = current_pos(1);
    mobile_manipulator_data.joints.actual.mobjoint3  = current_pos(2);
    mobile_manipulator_data.joints.actual.joint1     = current_pos(3);
    mobile_manipulator_data.joints.actual.joint2     = current_pos(4);
    mobile_manipulator_data.joints.actual.joint3     = current_pos(5);
    mobile_manipulator_data.joints.actual.joint4     = current_pos(6);
    mobile_manipulator_data.joints.actual.joint5     = current_pos(7);
    mobile_manipulator_data.joints.actual.joint6     = current_pos(8);
    mobile_manipulator_data.joints.desired.mobjoint1 = q_desired(0);
    mobile_manipulator_data.joints.desired.mobjoint2 = q_desired(1);
    mobile_manipulator_data.joints.desired.mobjoint3 = q_desired(2);
    mobile_manipulator_data.joints.desired.joint1    = q_desired(3);
    mobile_manipulator_data.joints.desired.joint2    = q_desired(4);
    mobile_manipulator_data.joints.desired.joint3    = q_desired(5);
    mobile_manipulator_data.joints.desired.joint4    = q_desired(6);
    mobile_manipulator_data.joints.desired.joint5    = q_desired(7);
    mobile_manipulator_data.joints.desired.joint6    = q_desired(8);

    pub_mob_manipulator_data->publish(mobile_manipulator_data);

    /******************************/
    // Publish commands to mobile platform
    if(using_only_manipulator){
        mobile_pltfrm_cmd.linear.x  = 0.0;
        mobile_pltfrm_cmd.linear.y  = 0.0;
        mobile_pltfrm_cmd.angular.z = 0.0;
    }
    else{
        mobile_pltfrm_cmd.linear.x  = q_dot_result(0);
        mobile_pltfrm_cmd.linear.y  = q_dot_result(1);
        mobile_pltfrm_cmd.angular.z = q_dot_result(2);
    }
    pub_mobile_platfrm->publish(mobile_pltfrm_cmd);

    /******************************/
    // Publish commands to manipulator as Float64MultiArray
    std_msgs::msg::Float64MultiArray efforts_msg;
    efforts_msg.data = {
        tau_result(3),
        tau_result(4),
        tau_result(5),
        tau_result(6),
        tau_result(7),
        tau_result(8)
    };
    pub_joint_efforts->publish(efforts_msg);
}

////////////////////////////////////////////////////////////////////////////////
// Function to update target based on data received from desired_traj topic
void MobManipulatorController::updateTarget(Eigen::VectorXd current_joint_pos){

    //--- Publish transform to desired pose frame
    transformDesiredPos.header.stamp = this->now();
    broadcaster_->sendTransform(transformDesiredPos);

    //--- Cartesian Target
    targetCartPos(0)   = mob_man_traj.pose.translation.x;
    targetCartPos(1)   = mob_man_traj.pose.translation.y;
    targetCartPos(2)   = mob_man_traj.pose.translation.z;
    targetCartVel(0)   = mob_man_traj.vel.linear.x;
    targetCartVel(1)   = mob_man_traj.vel.linear.y;
    targetCartVel(2)   = mob_man_traj.vel.linear.z;
    targetCartAccel(0) = mob_man_traj.accel.linear.x;
    targetCartAccel(1) = mob_man_traj.accel.linear.y;
    targetCartAccel(2) = mob_man_traj.accel.linear.z;

    //--- Orientation target
    Eigen::Quaterniond quat_des(mob_man_traj.pose.rotation.w, mob_man_traj.pose.rotation.x, mob_man_traj.pose.rotation.y, mob_man_traj.pose.rotation.z);
    targetOrientPos = quat_des.normalized().toRotationMatrix();
    targetOrientVel(0)   = mob_man_traj.vel.angular.x;
    targetOrientVel(1)   = mob_man_traj.vel.angular.y;
    targetOrientVel(2)   = mob_man_traj.vel.angular.z;
    targetOrientAccel(0) = mob_man_traj.accel.angular.x;
    targetOrientAccel(1) = mob_man_traj.accel.angular.y;
    targetOrientAccel(2) = mob_man_traj.accel.angular.z;

    //--- Joint Conf Desired
    q_desired(0) = current_joint_pos(0);
    q_desired(1) = current_joint_pos(1);
    q_desired(2) = mob_man_traj.joints.mobjoint3;
    q_desired(3) = mob_man_traj.joints.joint1;
    q_desired(4) = mob_man_traj.joints.joint2;
    q_desired(5) = mob_man_traj.joints.joint3;
    q_desired(6) = mob_man_traj.joints.joint4;
    q_desired(7) = mob_man_traj.joints.joint5;
    q_desired(8) = mob_man_traj.joints.joint6;

    for(size_t jj = 2; jj < (size_t)robot_dofs; jj++){
        if( q_desired(jj) == -10.0 ){
            q_desired(jj) = current_joint_pos(jj);
        }
    }
}

} /* namespace */