FROM mcr.microsoft.com/devcontainers/miniconda:0-3 AS base

ARG UNAME=vscode
ARG USER_ID=1000
ARG GROUP_ID=1000
ARG GITHUB_TOKEN

# This image already has a user vscode
USER root
# RUN groupmod -g $GROUP_ID $UNAME
# RUN usermod -u $USER_ID -g $GROUP_ID $UNAME

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends poppler-utils ffmpeg libsm6 libxext6 libglu1-mesa xz-utils \
    clang cmake ninja-build libgtk-3-dev scrot

ENV PATH=/home/$UNAME/.local/bin:$PATH

# Install Flutter
WORKDIR /opt
RUN wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.10.5-stable.tar.xz
RUN tar xf flutter_linux_3.10.5-stable.tar.xz
RUN rm flutter_linux_3.10.5-stable.tar.xz
RUN flutter upgrade

# Install chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN apt-get -y install ./google-chrome-stable_current_amd64.deb
RUN rm google-chrome-stable_current_amd64.deb

# Copy RobotLibraries.
RUN mkdir /tmp/conda-tmp/ && chmod -R 777 /tmp && chmod -R 777 /opt/conda
USER $UNAME
COPY conda.yaml* .devcontainer/noop.txt /tmp/conda-tmp/
COPY .devcontainer/resolve_conda_secret.py /tmp/conda-tmp//resolve_conda_secret.py

WORKDIR /tmp/conda-tmp/
RUN python resolve_conda_secret.py --token $GITHUB_TOKEN
RUN if [ -f "/tmp/conda-tmp/conda_pass.yaml" ]; then umask 0002 && conda env create -n robotframework -f /tmp/conda-tmp/conda_pass.yaml; fi 
RUN echo "conda activate robotframework" >> ~/.bashrc
RUN chmod -R a+rw /opt/conda/envs/robotframework/lib/python3.10/site-packages/Browser
RUN rm conda_pass.yaml

WORKDIR /workspaces
RUN rm -rf /tmp/conda-tmp/

ENV PATH=/opt/flutter/bin:$PATH
ENV TZ='/usr/share/zoneinfo/Europe/Madrid'
