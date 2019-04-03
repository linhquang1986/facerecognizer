#!/bin/bash
sudo apt-get update
sudo apt-get -y install build-essential # auto yes when install
if [ "!$(which cmake)" == "!" ]; then
  if ! [ -e cmake-3.6.3.tar.gz ]; then
    curl -k -o cmake-3.6.3.tar.gz https://cmake.org/files/v3.6/cmake-3.6.3.tar.gz
  fi
  if [ -e cmake-3.6.3.tar.gz ]; then
    tar -xvzf cmake-3.6.3.tar.gz
    cd cmake-3.6.3/
    sudo ./configure
    make
    sudo make install
    sudo update-alternatives --install /usr/bin/cmake cmake /usr/local/bin/cmake 1 --force
    cd ..
  fi
fi
