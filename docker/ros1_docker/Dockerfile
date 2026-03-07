# =====================
# Dockerfile para ROS1 Melodic + Gazebo + dependencias del repo
# =====================

FROM osrf/ros:melodic-desktop-full

# =====================
# Dependencias básicas de ROS, Gazebo y herramientas
# =====================
RUN apt-get update && apt-get install -y \
    git \
    wget \
    software-properties-common \
    ros-melodic-gazebo-ros \
    ros-melodic-gazebo-ros-control \
    ros-melodic-ros-control \
    ros-melodic-ros-controllers \
    ros-melodic-rqt \
    ros-melodic-rqt-common-plugins \
    ros-melodic-robot-localization \
    libeigen3-dev \
    && rm -rf /var/lib/apt/lists/*

# =====================
# DART (dinámica y física para el robot)
# =====================
RUN apt-add-repository ppa:dartsim/ppa && \
    apt-get update && \
    apt-get install -y libdart6-dev

# =====================
# Catkin Tools 
# =====================
RUN apt-get update && apt-get install -y curl lsb-release gnupg2 \
    && curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - \
    && echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list \
    && apt-get update \
    && apt-get install -y python-catkin-tools

# =====================
# Workspace
# =====================
WORKDIR /catkin_ws
RUN mkdir -p src

# =====================
# Build inicial (workspace vacío, solo para crear devel)
# =====================
RUN /bin/bash -c "source /opt/ros/melodic/setup.bash && catkin build -j 2"

# =====================
# Comando por defecto
# =====================
CMD ["bash"]