#pragma once

#include <iostream>
#include <algorithm>
#include <Eigen/Dense>
#include <Eigen/Geometry>
#include <math.h>
#include <vector>

#include "rclcpp/rclcpp.hpp"
#include <angles/angles.h>

#include <std_msgs/msg/float64.hpp>
#include <std_msgs/msg/float64_multi_array.hpp>
#include <sensor_msgs/msg/joint_state.hpp>
#include <geometry_msgs/msg/transform.hpp>
#include <geometry_msgs/msg/transform_stamped.hpp>
#include <geometry_msgs/msg/twist.hpp>
#include <nav_msgs/msg/odometry.hpp>

#include <mobile_manipulator_msgs/msg/mobile_manipulator.hpp>
#include <mobile_manipulator_msgs/msg/trajectory.hpp>

#include <tf2_ros/transform_broadcaster.h>
#include <tf2_ros/transform_listener.h>
#include <tf2_geometry_msgs/tf2_geometry_msgs.hpp>
#include <tf2/LinearMath/Quaternion.h>

#include <dart/dart.hpp>
// #include <dart/gui/osg/osg.hpp>  // no requerido en runtime
#include <dart/utils/urdf/urdf.hpp>
#include <dart/utils/utils.hpp>

#include <osc_controller/OSC_Controller.hpp>

namespace mob_manipulator_controller {

class MobManipulatorController : public rclcpp::Node {
public:
    explicit MobManipulatorController(const rclcpp::NodeOptions& options = rclcpp::NodeOptions());
    virtual ~MobManipulatorController();

private:
    // Subscriptores
    rclcpp::Subscription<sensor_msgs::msg::JointState>::SharedPtr   subs_joint_state_;
    rclcpp::Subscription<nav_msgs::msg::Odometry>::SharedPtr        subs_odometry_;
    rclcpp::Subscription<mobile_manipulator_msgs::msg::Trajectory>::SharedPtr subs_desired_traj_;

    // Publishers
    rclcpp::Publisher<geometry_msgs::msg::Twist>::SharedPtr               pub_mobile_platfrm;
    rclcpp::Publisher<std_msgs::msg::Float64MultiArray>::SharedPtr        pub_joint_efforts;  // → bridge
    rclcpp::Publisher<mobile_manipulator_msgs::msg::MobileManipulator>::SharedPtr pub_mob_manipulator_data;

    // TF
    std::shared_ptr<tf2_ros::TransformBroadcaster> broadcaster_;
    geometry_msgs::msg::TransformStamped transformDesiredPos;

    // Timer principal
    rclcpp::TimerBase::SharedPtr timer_;

    // Parámetros
    std::string robot_name;
    std::string robot_frame;
    int robot_dofs;
    double point_const_vel_max_lineal;
    double point_const_vel_max_angular;
    double pos_stiff_X, pos_stiff_Y, pos_stiff_Z;
    double pos_damp_X,  pos_damp_Y,  pos_damp_Z;
    double ori_stiff_X, ori_stiff_Y, ori_stiff_Z;
    double ori_damp_X,  ori_damp_Y,  ori_damp_Z;
    double mobile_base_p_gain, mobile_base_d_gain;
    double manipulator_p_gain, manipulator_d_gain;
    bool using_only_manipulator;
    std::string odometry_topic;
    std::vector<std::string> manipulator_dofs;
    int frecuency_rate;
    bool topdown_, jtspace_, augmented_;
    int method_sing_handling;
    int method_joint_limit_avoidance;
    int orient_error_calc;
    std::vector<std::string> model_packages_paths;
    std::vector<std::string> model_packages_names;
    std::string urdf_model_path;

    // Tiempo
    double time_previous_sjs;
    double time_actual_sjs;
    double min_sv_pos, min_sv_ori;

    // Mensajes
    geometry_msgs::msg::Twist                           mobile_pltfrm_cmd;
    mobile_manipulator_msgs::msg::MobileManipulator     mobile_manipulator_data;
    mobile_manipulator_msgs::msg::Trajectory            mob_man_traj;

    // Eigen
    Eigen::MatrixXd M;
    Eigen::VectorXd C_k, g_k;
    Eigen::VectorXd q_k, q_dot_k;
    Eigen::VectorXd tau_zero, tau_result, tau_joints, tau_ext;
    Eigen::VectorXd q_dot_zero, q_dot_result;
    Eigen::Vector3d targetCartPos, targetCartVel, targetCartAccel;
    Eigen::Matrix3d targetOrientPos;
    Eigen::Vector3d targetOrientVel, targetOrientAccel;
    Eigen::VectorXd q_desired;

    // DART
    dart::dynamics::SkeletonPtr  dart_robotSkeleton;
    dart::dynamics::BodyNode*    mEndEffector_;

    // OSC Controller
    osc_controller::OSC_Controller osc_controller_;

    // Callbacks
    void jointState_CB(const sensor_msgs::msg::JointState::SharedPtr msg);
    void odometry_CB(const nav_msgs::msg::Odometry::SharedPtr msg);
    void change_DesPose_CB(const mobile_manipulator_msgs::msg::Trajectory::SharedPtr msg);

    // Funciones
    bool readParameters();
    void spin();
    void loadDARTModel();
    void initMsgs();
    void calcTorqueDueTasks();
    void StackTasks(Eigen::MatrixXd *Null_space, Eigen::VectorXd *torque_ns, int cycle);
    void updateTarget(Eigen::VectorXd current_joint_pos);
};

} // namespace