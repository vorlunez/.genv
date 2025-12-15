#!/bin/bash
# sudo apt update
# sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

TIMES=5
for ((i=0; i<$TIMES; i++)); do
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
        if [ $? -eq 0 ]; then
                echo "curl command was successful"
                break
        else
                echo "curl command failed"
        fi
done

sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt update
sudo apt install -y docker-ce
sudo systemctl start docker && sudo systemctl enable docker
docker --version
