FROM ubuntu:18.04

ENV MOLECULE_VER 2.19.0
ENV ANSIBLE_VER 2.7.0
ENV LANG C.UTF-8

# Install.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y curl git wget

# Install docker-engine
RUN \
  apt-get install -y --no-install-recommends apt-transport-https ca-certificates gpg-agent software-properties-common && \
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
  add-apt-repository "deb https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
  apt-get update && \
  apt-get -y install docker-ce

# Install
RUN \
  apt-get --no-install-recommends -y install python3 python3-apt python3-pip python3-dev python-setuptools gcc libssl-dev libffi-dev && \
  pip3 install -U pip && \
  pip install setuptools && \
  pip install molecule==${MOLECULE_VER} ansible==${ANSIBLE_VER} docker && \
  apt autoremove -y \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Define default command.
CMD ["bash"]
