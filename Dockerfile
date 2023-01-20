# Slicer/SlicerDocker
# https://github.com/Slicer/SlicerDocker/blob/main/slicer-notebook/Dockerfile

FROM lassoan/slicer-notebook:5.0.3

# Configure environment
ENV DOCKER_IMAGE_NAME='image3d-env'
ENV VERSION='2023-01-20' 

# Docker name to shell prompt
ENV PS1A="[docker] \[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$"
RUN echo 'PS1=$PS1A' >> ~/.bashrc

# Install Slicer extensions
ADD install_SlicerExtensions.py ${HOME}/
ADD install.sh ${HOME}/
RUN bash ${HOME}/install.sh ${HOME}/Slicer/Slicer
RUN rm install_SlicerExtensions.py
RUN rm install.sh

# Install external Python packages
ADD requirements.txt .
RUN ./Slicer/bin/PythonSlicer -m pip install -r requirements.txt 

ADD scripts/entrypoint.sh /
ADD scripts/launch_slicer_jupyter.sh /
ADD scripts/message.sh /
RUN echo "bash /message.sh" >> ~/.bashrc

CMD ["sh", "-c", "/home/sliceruser/Slicer/bin/PythonSlicer -m jupyter lab --port=$JUPYTERPORT --allow-root --ip=0.0.0.0"]