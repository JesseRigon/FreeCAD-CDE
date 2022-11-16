FROM gitpod/workspace-full-vnc

USER root

RUN sudo apt-get update && apt-get upgrade -y && apt-get autoremove && apt-get autoclean
