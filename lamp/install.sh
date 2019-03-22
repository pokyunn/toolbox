#!/usr/bin/env bash

# Set locale and timezone
sudo dpkg-reconfigure --frontend noninteractive tzdata
sudo locale-gen en_US.UTF-8 pt_BR.UTF-8
sudo update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

startTime=`date +%s`

# Update system
sudo apt-get update \
    && apt-get -y dist-upgrade \
    && apt-get autoclean \
    && apt-get autoremove \
    && apt-get clean

# Utilities
apt-get install -y git openssh-client openssh-server tree htop
sudo bash /etc/bash_completion

# Install services
bash ./php/install.sh
bash ./apache/install.sh
bash ./node/install.sh

endTime=`date +%s`
diff=`expr $endTime - $startTime`
fixedTime=`expr 10800 + $diff`
result=`date -d @$fixedTime +%H:%M:%S`
echo " Tempo gasto: $result "
