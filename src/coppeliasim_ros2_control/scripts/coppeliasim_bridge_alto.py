#!/usr/bin/env python3

import math
import rclpy
from rclpy.node import Node
from sensor_msgs.msg import JointState
from std_msgs.msg import Float64MultiArray
from geometry_msgs.msg import Twist
from nav_msgs.msg import Odometry
from coppeliasim_zmqremoteapi_client import RemoteAPIClient


ARM_JOINT_NAMES = [
    'waist_joint',
    'shoulder_joint',
    'elbow_joint',
    'upper_forearm_joint',
    'lower_forearm_joint',
    'wrist_joint',
]


class CoppeliaSimBridge(Node):

    def __init__(self):
        super().__init__('coppeliasim_bridge')

        self.get_logger().info('Conectando a CoppeliaSim...')
        self.client = RemoteAPIClient()
        self.sim = self.client.require('sim')

        # Activar stepping síncrono
        self.client.setStepping(True)
        self.sim.startSimulation()

        self.get_logger().info('Simulación iniciada.')

        # Obtener handle del robot
        self.robot_handle = self.sim.getObject('/mobile_manipulator')

        # Obtener handle del child script
        self.script_handle = self.sim.getScript(
            self.sim.scripttype_childscript,
            self.robot_handle
        )

        if self.script_handle == -1:
            raise RuntimeError("No se encontró child script en mobile_manipulator")

        # Buffers de comando
        self.tau_cmd = [0.0]*6
        self.wheel_cmd = [0.0]*3

        # Publishers
        self.js_pub = self.create_publisher(
            JointState,
            '/mobile_manipulator/joint_states',
            10
        )

        self.odom_pub = self.create_publisher(
            Odometry,
            '/mobile_manipulator/odom',
            10
        )

        # Subscribers
        self.create_subscription(
            Float64MultiArray,
            '/mobile_manipulator/joint_efforts',
            self.effort_callback,
            10
        )

        self.create_subscription(
            Twist,
            '/mobile_manipulator/commands/velocity',
            self.velocity_callback,
            10
        )

        self.dt = 0.01  # 100 Hz
        self.timer = self.create_timer(self.dt, self.control_loop)

        self.get_logger().info('Bridge activo a 100 Hz.')

    # -------------------------------------------------

    def effort_callback(self, msg):
        if len(msg.data) == 6:
            self.tau_cmd = list(msg.data)

    def velocity_callback(self, msg):

        vx = msg.linear.x
        vy = msg.linear.y
        wz = msg.angular.z

        R = 0.1825
        r = 0.06

        alphas = [
            math.pi/2,
            math.pi/2 + 2*math.pi/3,
            math.pi/2 - 2*math.pi/3
        ]

        wheel = []
        for a in alphas:
            v = (-math.sin(a)*vx +
                  math.cos(a)*vy +
                  R*wz) / r
            wheel.append(v)

        self.wheel_cmd = wheel

    # -------------------------------------------------

    def control_loop(self):

        # Enviar comandos
        self.sim.callScriptFunction(
            'setCommands',
            self.script_handle,
            {
                'tau': self.tau_cmd,
                'wheels': self.wheel_cmd
            }
        )

        # Avanzar simulación un step
        self.client.step()

        # Obtener estado
        state = self.sim.callScriptFunction(
            'getState',
            self.script_handle,
            {}
        )

        # Publicar JointState
        js = JointState()
        js.header.stamp = self.get_clock().now().to_msg()
        js.name = ARM_JOINT_NAMES
        js.position = state['q']
        js.velocity = state['dq']
        js.effort = self.tau_cmd
        self.js_pub.publish(js)

        # Publicar Odometry
        odom = Odometry()
        odom.header.stamp = js.header.stamp
        odom.header.frame_id = 'odom'
        odom.child_frame_id = 'mobile_base_link'

        pos = state['base_pos']
        ori = state['base_ori']

        odom.pose.pose.position.x = pos[0]
        odom.pose.pose.position.y = pos[1]
        odom.pose.pose.position.z = pos[2]

        odom.pose.pose.orientation.x = ori[0]
        odom.pose.pose.orientation.y = ori[1]
        odom.pose.pose.orientation.z = ori[2]
        odom.pose.pose.orientation.w = ori[3]

        self.odom_pub.publish(odom)

    # -------------------------------------------------

    def destroy_node(self):
        self.sim.stopSimulation()
        super().destroy_node()


def main(args=None):
    rclpy.init(args=args)
    node = CoppeliaSimBridge()
    try:
        rclpy.spin(node)
    except KeyboardInterrupt:
        pass
    finally:
        node.destroy_node()
        rclpy.shutdown()


if __name__ == '__main__':
    main()