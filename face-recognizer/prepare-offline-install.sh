#!/bin/bash

if [ $USER != "root" ] ; then
   echo "should be root."
   exit 1
fi

apt -o Acquire::AllowInsecureRepositories=true  -o Acquire::AllowDowngradeToInsecureRepositories=true  update
apt install -y jq lib32z1

