#!/bin/bash

if [ -z $1 ];then
       echo "input target directory please"
       return 0
fi

if [ ! -d $1 ]; then
       echo "directory $1 not exist"
       return 0
fi

repos=(https://gitlab.freedesktop.org/wayland/wayland.git
       https://gitlab.freedesktop.org/wayland/wayland-protocols.git)

for repo in ${repos[@]}
do
       git clone $repo $1/$(basename $repo .git)
done

# for wayland
sudo apt install -y pkg-config libxml2-dev graphviz doxygen xsltproc xmlto \
ninja-build expat libffi-dev libwayland-dev

cd $1/wayland
meson setup build && ninja -C build
sudo ninja -C build install  

cd $1/wayland-protocols
meson setup build && ninja -C build
sudo ninja -C build install