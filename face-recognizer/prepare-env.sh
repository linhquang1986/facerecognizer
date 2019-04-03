#!/bin/bash

PACKAGES=" git-core subversion "
#PACKAGER_OPT=" -y -qq"
#PACKAGER_OPT=" -y -q"
PACKAGER_OPT=" -y "

sudo apt-get update 
sudo apt-get install ${PACKAGER_OPT} ${PACKAGES}

# Execution Framework

sudo apt-get install -y linux-image-extra-$(uname -r) linux-image-extra-virtual
sudo apt-get install -y apt-transport-https ca-certificates
sudo apt-get install -y curl

curl -fsSL https://yum.dockerproject.org/gpg | sudo apt-key add -

sudo apt-get install -y software-properties-common

# install docker
sudo apt-mark unhold docker docker-engine docker.io
sudo apt-mark unhold docker-ce 
sudo apt-get remove docker docker-engine docker.io

#sudo add-apt-repository "deb https://apt.dockerproject.org/repo/ ubuntu-$(lsb_release -cs) main"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -yq docker-ce=17.09.0~ce-0~ubuntu
sudo apt-mark hold docker-ce

sudo apt-get install -y  cppcheck libcurl4-gnutls-dev build-essential git liblog4cxx10-dev python 

sudo apt-get install -y zip cppcheck libcurl4-gnutls-dev build-essential git liblog4cxx10-dev python

