#!/bin/bash

sleep 5m

#Install Driver and nvidia-docker
apt-get install -qq linux-headers-`uname -r`
chmod +x /tools/NVIDIA-Linux-x86_64-375.20.run
sh /tools/NVIDIA-Linux-x86_64-375.20.run -a -s
dpkg -i /tools/nvidia-docker_1.0.0.rc.3-1_amd64.deb

#Get sources and build a docker image
cd /home/agent
git clone https://github.com/wbuchwalter/on-demand-training-vsts
cd on-demand-training-vsts

sudo docker build -f Dockerfile.train -t cntk-mnist .

#Run the training, with a volume to save output
sudo nvidia-docker run cntk-mnist $1
