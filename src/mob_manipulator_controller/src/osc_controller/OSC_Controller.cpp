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

#include <osc_controller/OSC_Controller.hpp>

namespace osc_controller {

using namespace dart::common;
using namespace dart::dynamics;
using namespace dart::math;

////////////////////////////////////////////////////////////////////////////////
// Constructor
OSC_Controller::OSC_Controller(){

    //----------------------------------------------------------------------//
    /* Variables for task hierarchy */
    augmented_projections = true;
    compensate_topdown  = false;
    compensate_jtspace  = true;

    //----------------------------------------------------------------------//
    /* Variable for selecting the singularity handling method */
    // 0 -> Algorithm proposed by Khatib et al.
    // 1 -> Algorithm without torque projection
    // 2 -> Algorithm with non singular torque projection
    singularity_handling_method = 2;

    //----------------------------------------------------------------------//
    // Gain Matrices definition
    kp_cartesian_ = Eigen::MatrixXd::Identity(6, 6);
    kp_cartesian_.topLeftCorner(2, 2)     = 400.0*Eigen::MatrixXd::Identity(2, 2);
    kp_cartesian_(2,2)                    = 400.0;
    kp_cartesian_.bottomRightCorner(3, 3) = 400.0*Eigen::MatrixXd::Identity(3, 3);

    kd_cartesian_ = Eigen::MatrixXd::Identity(6, 6);
    kd_cartesian_.topLeftCorner(2, 2)     = 0.9*Eigen::MatrixXd::Identity(2, 2);
    kd_cartesian_(2,2)                    = 0.9;
    kd_cartesian_.bottomRightCorner(3, 3) = 0.9*Eigen::MatrixXd::Identity(3, 3);

    kp_joints_ = Eigen::MatrixXd::Identity(9, 9);
    kp_joints_.topLeftCorner(2, 2)     = 0.0*Eigen::MatrixXd::Identity(2, 2);
    kp_joints_(2,2)                    = 0.0;
    kp_joints_.bottomRightCorner(6, 6) = 0.0*Eigen::MatrixXd::Identity(6, 6);

    kd_joints_ = Eigen::MatrixXd::Identity(9, 9);
    kd_joints_.topLeftCorner(2, 2)     = 10.0*Eigen::MatrixXd::Identity(2, 2);
    kd_joints_(2,2)                    = 10.0;
    kd_joints_.bottomRightCorner(6, 6) = 57.0*Eigen::MatrixXd::Identity(6, 6);

    //----------------------------------------------------------------------//
    //--- Select orientation error function
    ori_error_mode = 5;

    //----------------------------------------------------------------------//
    //--- Max vel for straight line tasks
    max_lineal_vel_  = 0.3;
    max_angular_vel_ = M_PI;

    //----------------------------------------------------------------------//
    //--- Gains for admittance controller
    admittance_linear_damping = 800.0;
    admittance_angular_damping = 800.0;
    admittance_desired_inertia = Eigen::MatrixXd::Identity(3,3);

    //----------------------------------------------------------------------//
    //--- Margins for singular value analysis
    singularity_thres_high_ = 10.0;
    singularity_thres_low_  = 1.0;

    singularity_thres_high_ori_ = 10.0;
    singularity_thres_low_ori_  = 1.0;

    singularity_thres_high_pos_ = 0.3;
    singularity_thres_low_pos_  = 0.1;

    //----------------------------------------------------------------------//
    //--- Parameters for avoid joint limits task
    joint_limit_handling_method = 0;

    Lower_limits = Eigen::VectorXd::Zero(9);
    Upper_limits = Eigen::VectorXd::Zero(9);

    Lower_limits(3) = - M_PI;
    Upper_limits(3) =   M_PI;
    Lower_limits(4) =  (-106.0/180.0) * M_PI;
    Upper_limits(4) =  (101.0/180.0) * M_PI;
    Lower_limits(5) =  (-92.0/180.0) * M_PI;
    Upper_limits(5) =  (101.0/180.0) * M_PI;
    Lower_limits(6) = - M_PI;
    Upper_limits(6) =   M_PI;
    Lower_limits(7) =  (-130.0/180.0) * M_PI;
    Upper_limits(7) =  (107.0/180.0) * M_PI;
    Lower_limits(8) = - M_PI;
    Upper_limits(8) =   M_PI;

    joint_margin_ = Eigen::VectorXd::Zero(9);
    joint_margin_(3) = 0.05*(Upper_limits(3) - Lower_limits(3));
    joint_margin_(4) = 0.05*(Upper_limits(4) - Lower_limits(4));
    joint_margin_(5) = 0.05*(Upper_limits(5) - Lower_limits(5));
    joint_margin_(6) = 0.05*(Upper_limits(6) - Lower_limits(6));
    joint_margin_(7) = 0.05*(Upper_limits(7) - Lower_limits(7));
    joint_margin_(8) = 0.05*(Upper_limits(8) - Lower_limits(8));
    
    eta_firas_  = 1.0;

    joint_limit_buffer = Eigen::VectorXd::Zero(9);
    joint_limit_buffer(3) = 0.05*(Upper_limits(3) - Lower_limits(3));
    joint_limit_buffer(4) = 0.05*(Upper_limits(4) - Lower_limits(4));
    joint_limit_buffer(5) = 0.05*(Upper_limits(5) - Lower_limits(5));
    joint_limit_buffer(6) = 0.05*(Upper_limits(6) - Lower_limits(6));
    joint_limit_buffer(7) = 0.05*(Upper_limits(7) - Lower_limits(7));
    joint_limit_buffer(8) = 0.05*(Upper_limits(8) - Lower_limits(8));

    gain_limit_avoidance = 400.0;
    scale_null_space = 0.5;
    interm_alg_update_null = 2;

    Max_constraint_accel = Eigen::VectorXd::Zero(9);
    Min_constraint_accel = Eigen::VectorXd::Zero(9);

    Max_joint_accel = Eigen::VectorXd::Zero(9);
    Min_joint_accel = Eigen::VectorXd::Zero(9);

    Max_joint_vel = Eigen::VectorXd::Zero(9);
    Min_joint_vel = Eigen::VectorXd::Zero(9);

    Max_joint_pos = Eigen::VectorXd::Zero(9);
    Min_joint_pos = Eigen::VectorXd::Zero(9);
}

////////////////////////////////////////////////////////////////////////////////
// Destructor
OSC_Controller::~OSC_Controller()
{
}

////////////////////////////////////////////////////////////////////////////////
// Function to change the cartesian position gains
void OSC_Controller::changeCartesianPositionGains(double Pos_X_stiffness, 
                                                double Pos_Y_stiffness, 
                                                double Pos_Z_stiffness,
                                                double Pos_X_damping, 
                                                double Pos_Y_damping, 
                                                double Pos_Z_damping){
    kp_cartesian_(0,0) = Pos_X_stiffness;
    kp_cartesian_(1,1) = Pos_Y_stiffness;
    kp_cartesian_(2,2) = Pos_Z_stiffness;

    kd_cartesian_(0,0) = Pos_X_damping;
    kd_cartesian_(1,1) = Pos_Y_damping;
    kd_cartesian_(2,2) = Pos_Z_damping;
}

////////////////////////////////////////////////////////////////////////////////
// Function to change the cartesian orientation gains
void OSC_Controller::changeCartesianOrientationGains(double Ori_X_stiffness, 
                                                    double Ori_Y_stiffness, 
                                                    double Ori_Z_stiffness,
                                                    double Ori_X_damping, 
                                                    double Ori_Y_damping, 
                                                    double Ori_Z_damping){
    kp_cartesian_(3,3) = Ori_X_stiffness;
    kp_cartesian_(4,4) = Ori_Y_stiffness;
    kp_cartesian_(5,5) = Ori_Z_stiffness;

    kd_cartesian_(3,3) = Ori_X_damping;
    kd_cartesian_(4,4) = Ori_Y_damping;
    kd_cartesian_(5,5) = Ori_Z_damping;
}

////////////////////////////////////////////////////////////////////////////////
// Function to change the joint tasks gains
void OSC_Controller::changeJointTaskGains(double Mob_base_P_Gain, 
                                        double Mob_base_D_Gain, 
                                        double Manipulator_P_Gain, 
                                        double Manipulator_D_Gain){
    
    kp_joints_ = Eigen::MatrixXd::Identity(9, 9);
    kp_joints_.topLeftCorner(3, 3)     = Mob_base_P_Gain*Eigen::MatrixXd::Identity(3, 3);
    kp_joints_.bottomRightCorner(6, 6) = Manipulator_P_Gain*Eigen::MatrixXd::Identity(6, 6);

    kd_joints_ = Eigen::MatrixXd::Identity(9, 9);
    kd_joints_.topLeftCorner(3, 3)     = Mob_base_D_Gain*Eigen::MatrixXd::Identity(3, 3);
    kd_joints_.bottomRightCorner(6, 6) = Manipulator_D_Gain*Eigen::MatrixXd::Identity(6, 6);
}

////////////////////////////////////////////////////////////////////////////////
// Function to calculate the efforts required to Achieve a joint configuration
void OSC_Controller::AchieveJointConf(  Eigen::VectorXd q_desired, 
                                    Eigen::MatrixXd M, 
                                    Eigen::VectorXd C_t,
                                    Eigen::VectorXd g_t,
                                    dart::dynamics::SkeletonPtr mRobot,
                                    dart::dynamics::BodyNode* mEndEffector,
                                    Eigen::VectorXd *tau_total,
                                    Eigen::MatrixXd *Null_space_iter){

    std::size_t dofs = mEndEffector->getNumDependentGenCoords();

    Eigen::VectorXd q_dot_desired = Eigen::VectorXd::Zero(dofs); 

    Eigen::VectorXd current_q = mRobot->getPositions();

    Eigen::VectorXd pos_er = q_desired - mRobot->getPositions();
    Eigen::VectorXd vel_er = q_dot_desired - mRobot->getVelocities();

    Eigen::VectorXd q_star = kd_joints_ * vel_er + kp_joints_ * pos_er; 

    if(compensate_topdown){
        q_star = q_star - M.inverse() * *tau_total;
    }
    
    Eigen::VectorXd tau_star = Eigen::VectorXd::Zero(dofs);
    if(compensate_jtspace){
        tau_star = M * q_star;
    }
    else{
        tau_star = M * q_star + C_t + g_t;
    }

    Eigen::VectorXd tau_projected = (*Null_space_iter) * tau_star;   

    *tau_total = *tau_total + tau_projected; 
}

////////////////////////////////////////////////////////////////////////////////
// Function to calculate non-singular operational kinetic energy matrix
Eigen::MatrixXd OSC_Controller::calcInertiaMatrix(Eigen::MatrixXd Alpha_inv, double* min_svd){

    Eigen::JacobiSVD<Eigen::MatrixXd> svd(Alpha_inv, Eigen::ComputeFullU | Eigen::ComputeThinV);

    Eigen::VectorXd svd_values = svd.singularValues();
    Eigen::MatrixXd Full_U = svd.matrixU(); 

    int dofs = (int)svd_values.size();

    Eigen::VectorXd small_svd = Eigen::MatrixXd::Zero(dofs,1);

    for (int ii = 0; ii < dofs; ii++){
        if(abs(svd_values(ii)) < singularity_thres_high_){
            small_svd(ii) = 1;
        }
        if( abs(svd_values(ii)) < *min_svd ){
            *min_svd = abs(svd_values(ii));
        }
    }

    Eigen::MatrixXd Alpha_ns = Eigen::MatrixXd::Zero(dofs,dofs);

    if(small_svd.sum() > 0){

        int ns_count = dofs - (int)small_svd.sum();
        Eigen::MatrixXd U_ns = Eigen::MatrixXd::Zero(dofs, ns_count);
        Eigen::MatrixXd svd_values_ns = Eigen::MatrixXd::Zero(ns_count, ns_count);

        int aux_counter_ns = 0;  // FIX: era double, ahora int
        for (int ii = 0; ii < dofs; ii++){
            if(small_svd(ii) != 1){
                for (int jj = 0; jj < dofs; jj++){
                    U_ns(jj, aux_counter_ns) = Full_U(jj, ii);
                }
                svd_values_ns(aux_counter_ns, aux_counter_ns) = svd_values(ii);
                aux_counter_ns++;
            }
        }

        Alpha_ns = U_ns * svd_values_ns.inverse() * U_ns.transpose();
    }
    else{
        Alpha_ns = Alpha_inv.inverse();
    }
    return Alpha_ns;
}

////////////////////////////////////////////////////////////////////////////////
// Function to calculate non-singular operational kinetic energy matrix (with handling)
void OSC_Controller::calcInertiaMatrixHandling( Eigen::MatrixXd Alpha_inv,
                                            double* min_svd,
                                            double* act_param,
                                            Eigen::MatrixXd *Alpha_ns,
                                            Eigen::MatrixXd *Alpha_s,
                                            Eigen::MatrixXd *Alpha_s_dummy){

    Eigen::JacobiSVD<Eigen::MatrixXd> svd(Alpha_inv, Eigen::ComputeFullU | Eigen::ComputeThinV);

    Eigen::VectorXd svd_values = svd.singularValues();
    Eigen::MatrixXd Full_U = svd.matrixU(); 

    int dofs = (int)svd_values.size();

    Eigen::VectorXd small_svd = Eigen::MatrixXd::Zero(dofs,1);

    for (int ii = 0; ii < dofs; ii++){
        if(abs(svd_values(ii)) < singularity_thres_high_){
            small_svd(ii) = 1;
        }
        if( abs(svd_values(ii)) < *min_svd ){
            *min_svd = abs(svd_values(ii));
        }
    }

    *Alpha_ns = Eigen::MatrixXd::Zero(dofs,dofs);

    if(small_svd.sum() > 0){

        int ns_count = dofs - (int)small_svd.sum();
        int s_count  = (int)small_svd.sum();

        Eigen::MatrixXd U_ns = Eigen::MatrixXd::Zero(dofs, ns_count);
        Eigen::MatrixXd svd_values_ns = Eigen::MatrixXd::Zero(ns_count, ns_count);

        Eigen::MatrixXd U_s = Eigen::MatrixXd::Zero(dofs, s_count);
        Eigen::MatrixXd svd_values_s = Eigen::MatrixXd::Zero(s_count, s_count);
        Eigen::MatrixXd svd_values_s_dummy = Eigen::MatrixXd::Zero(s_count, s_count);

        int aux_counter_ns = 0;  // FIX: era double, ahora int
        int aux_counter_s  = 0;  // FIX: era double, ahora int
        for (int ii = 0; ii < dofs; ii++){

            if(small_svd(ii) != 1){
                for (int jj = 0; jj < dofs; jj++){
                    U_ns(jj, aux_counter_ns) = Full_U(jj, ii);
                }
                svd_values_ns(aux_counter_ns, aux_counter_ns) = svd_values(ii);
                aux_counter_ns++;
            }
            else{
                for (int jj = 0; jj < dofs; jj++){
                    U_s(jj, aux_counter_s) = Full_U(jj, ii);
                }
                svd_values_s(aux_counter_s, aux_counter_s) = svd_values(ii);
                svd_values_s_dummy(aux_counter_s, aux_counter_s) = singularity_thres_high_;
                aux_counter_s++;
            }
        }

        *Alpha_ns      = U_ns * svd_values_ns.inverse() * U_ns.transpose();
        *Alpha_s_dummy = U_s  * svd_values_s_dummy.inverse() * U_s.transpose();
        if(*min_svd >= singularity_thres_low_){
            *Alpha_s   = U_s  * svd_values_s.inverse() * U_s.transpose();
        }
        else{
            *Alpha_s   = Eigen::MatrixXd::Zero(dofs,dofs);
        }
    }
    else{
        *Alpha_ns      = Alpha_inv.inverse();
        *Alpha_s       = Eigen::MatrixXd::Zero(dofs,dofs);
        *Alpha_s_dummy = Eigen::MatrixXd::Zero(dofs,dofs);
    }

    // Calculate activation parameter
    if(*min_svd > singularity_thres_high_){
        *act_param = 1.0;
    }
    else if(*min_svd < singularity_thres_low_){
        *act_param = 0.0;
    }
    else{
        *act_param = 0.5 + 0.5*sin( (M_PI/(singularity_thres_high_-singularity_thres_low_))*( *min_svd - singularity_thres_low_ ) - M_PI_2 );
    }
}

////////////////////////////////////////////////////////////////////////////////
// Function to calculate damping matrix
Eigen::MatrixXd OSC_Controller::calcDampingMatrix(Eigen::MatrixXd Alpha, 
                                            Eigen::MatrixXd Stiffness, 
                                            Eigen::MatrixXd DampingCoeff){

    Eigen::MatrixXd Q = Alpha.llt().matrixL();
    Eigen::MatrixXd K_d0 = Q.inverse() * Stiffness * (Q.transpose()).inverse();
    Eigen::MatrixXd K_d0_sqrt = K_d0.llt().matrixL();
    Eigen::MatrixXd Damping = 2 * Q * DampingCoeff * K_d0_sqrt * Q.transpose();

    return Damping;
}

} /* namespace */