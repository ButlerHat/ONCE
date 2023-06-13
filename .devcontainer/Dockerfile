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
    && apt-get -y install --no-install-recommends poppler-utils ffmpeg libsm6 libxext6

ENV PATH=/home/$UNAME/.local/bin:$PATH

# Copy RobotLibraries.
RUN mkdir /tmp/pip-tmp && chmod -R 777 /tmp && chmod -R 777 /opt/conda
USER $UNAME
COPY conda.yaml /tmp/pip-tmp/conda.yaml
COPY .devcontainer/resolve_conda_secret.py /tmp/pip-tmp/resolve_conda_secret.py

WORKDIR /tmp/pip-tmp
RUN python resolve_conda_secret.py --token $GITHUB_TOKEN
RUN conda env update -n base -f conda_pass.yaml

WORKDIR /workspaces
RUN rm -rf /tmp/pip-tmp

ENV TZ='/usr/share/zoneinfo/Europe/Madrid'