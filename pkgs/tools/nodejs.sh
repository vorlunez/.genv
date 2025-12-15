#!/bin/bash
sudo apt install nodejs npm -y
sudo npm install -g vsce
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
nvm install node && nvm use node
