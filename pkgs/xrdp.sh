#!/bin/bash
# install xrdp remote desktop
sudo apt install xfce4 xfce4-goodies -y
sudo apt install xrdp -y
# 安装中文字体（如果需要）
sudo apt install fonts-wqy-zenhei -y

# 设置时区（例如上海）
sudo timedatectl set-timezone Asia/Shanghai
echo "startxfce4" > ~/.xsession8
