#!/usr/bin/env python3
"""
CoppeliaSim Hardware Bridge Node
Conecta ros2_control con CoppeliaSim via ZMQ Remote API.

Suscribe:  /coppeliasim/joint_efforts  (Float64MultiArray) — torques del WBC
Publica:   /joint_states               (sensor_msgs/JointState)  — q, dq
"""

import rclpy
from rclpy.node import Node
from sensor_msgs.msg import JointState
from std_msgs.msg import Float64MultiArray
from coppeliasim_zmqremoteapi_client import RemoteAPIClient
import time

JOINT_NAMES = [
    'mobile_manipulator/wheel0_joint',
    'mobile_manipulator/wheel1_joint',
    'mobile_manipulator/wheel2_joint',
    'mobile_manipulator/waist_joint',
    'mobile_manipulator/shoulder_joint',
    'mobile_manipulator/elbow_joint',
    'mobile_manipulator/upper_forearm_joint',
    'mobile_manipulator/lower_forearm_joint',
    'mobile_manipulator/wrist_joint',
]

# Joints que reciben torque del WBC (brazo)
ARM_JOINT_NAMES = [
    'mobile_manipulator/waist_joint',
    'mobile_manipulator/shoulder_joint',
    'mobile_manipulator/elbow_joint',
    'mobile_manipulator/upper_forearm_joint',
    'mobile_manipulator/lower_forearm_joint',
    'mobile_manipulator/wrist_joint',
]


class CoppeliaSimBridge(Node):

    def __init__(self):
        super().__init__('coppeliasim_bridge')

        # --- Conectar a CoppeliaSim ---
        self.get_logger().info('Conectando a CoppeliaSim...')
        self.sim = RemoteAPIClient().require('sim')
        self.get_logger().info('Conexión establecida.')

        # --- Obtener handles por nombre (nunca hardcodeados) ---
        self.handles = {}
        for name in JOINT_NAMES:
            h = self.sim.getObject(f'/{name}')
            self.handles[name] = h
            self.get_logger().info(f'  {name} → handle={h}')

        # --- Activar modo fuerza en joints del brazo ---
        for name in ARM_JOINT_NAMES:
            self.sim.setJointMode(self.handles[name], self.sim.jointmode_force, 0)
        self.get_logger().info('Joints del brazo en modo fuerza.')

        # --- Buffers de torque (inicializados a 0) ---
        self.effort_cmd = {name: 0.0 for name in ARM_JOINT_NAMES}

        # --- Publisher: joint states ---
        self.js_pub = self.create_publisher(JointState, '/joint_states', 10)

        # --- Subscriber: torques del WBC ---
        self.effort_sub = self.create_subscription(
            Float64MultiArray,
            '/coppeliasim/joint_efforts',
            self.effort_callback,
            10
        )

        # --- Timer: loop principal a 200 Hz ---
        self.timer = self.create_timer(0.005, self.control_loop)
        self.get_logger().info('Bridge activo a 200 Hz.')

    def effort_callback(self, msg: Float64MultiArray):
        """Recibe [tau_waist, tau_shoulder, tau_elbow,
                   tau_upper_forearm, tau_lower_forearm, tau_wrist]"""
        if len(msg.data) != len(ARM_JOINT_NAMES):
            self.get_logger().warn(
                f'Se esperaban {len(ARM_JOINT_NAMES)} torques, '
                f'llegaron {len(msg.data)}')
            return
        for i, name in enumerate(ARM_JOINT_NAMES):
            self.effort_cmd[name] = msg.data[i]

    def control_loop(self):
        try:
            # 1. Enviar torques a CoppeliaSim
            for name, tau in self.effort_cmd.items():
                self.sim.setJointTargetForce(self.handles[name], tau)

            # 2. Leer estados de todos los joints
            js = JointState()
            js.header.stamp = self.get_clock().now().to_msg()
            js.name     = JOINT_NAMES
            js.position = [self.sim.getJointPosition(self.handles[n]) for n in JOINT_NAMES]
            js.velocity = [self.sim.getJointVelocity(self.handles[n]) for n in JOINT_NAMES]
            js.effort   = [self.effort_cmd.get(n, 0.0) for n in JOINT_NAMES]

            self.js_pub.publish(js)

        except Exception as e:
            self.get_logger().error(f'Error en control loop: {e}')


def main(args=None):
    rclpy.init(args=args)
    node = CoppeliaSimBridge()
    try:
        rclpy.spin(node)
    except KeyboardInterrupt:
        pass
    finally:
        # Limpiar: modo cinemático al salir
        for name in ARM_JOINT_NAMES:
            try:
                node.sim.setJointTargetForce(node.handles[name], 0.0)
                node.sim.setJointMode(node.handles[name], node.sim.jointmode_kinematic, 0)
            except:
                pass
        node.destroy_node()
        rclpy.shutdown()


if __name__ == '__main__':
    main()
