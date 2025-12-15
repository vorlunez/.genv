#!/bin/bash

if [ -z $1 ];then
       echo "input target directory please"
       return 0
fi

if [ ! -d $1 ]; then
       echo "directory $1 not exist"
       return 0
fi

git clone https://gitlab.freedesktop.org/wayland/weston.git $1
sudo apt install -y pkg-config libxml2-dev graphviz doxygen xsltproc xmlto \
ninja-build libpixman-1-dev libcairo2-dev libpango1.0-dev libjpeg8-dev libgif-dev \
libinput-dev libdrm-dev libwebp-dev libsystemd-dev virtualenv build-essential \
python3-dev libdbus-glib-1-dev libgirepository1.0-dev libgbm-dev libva-dev \
freerdp2-dev libxcb-composite0-dev libxcursor-dev liblcms2-dev libsqlite3-dev \
valac gettext libgusb-dev libpolkit-gobject-1-dev libgstreamer1.0-dev \
libgstreamer-plugins-base1.0-dev libgstreamer-plugins-bad1.0-dev \
gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad \
gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-tools gstreamer1.0-x \
gstreamer1.0-alsa gstreamer1.0-gl gstreamer1.0-gtk3 gstreamer1.0-qt5 \
gstreamer1.0-pulseaudio libxkbcommon-dev libseat-dev libpipewire-0.3-dev

# install colord
# read -p "install colord ?[Y/N]" ANSWER
# if [ "$ANSWER" = "Y" ] || [ "$ANSWER" = "y" ]; then
#         sudo groupadd -g 71 colord
#         sudo useradd -c "Color Daemon Owner" -d /var/lib/colord -u 71 \
#                 -g colord -s /bin/false colord

#         wget https://www.freedesktop.org/software/colord/releases/colord-1.4.6.tar.xz
#         tar -xvf ./colord-1.4.6.tar.xz
#         mkdir build && cd build
#         meson --prefix=/usr            \
#         --buildtype=release      \
#         -Ddaemon_user=colord     \
#         -Dvapi=true              \
#         -Dsystemd=false          \
#         -Dlibcolordcompat=true   \
#         -Dargyllcms_sensor=false \
#         -Dbash_completion=false  \
#         -Ddocs=false             \
#         -Dman=false ..           &&
#         ninja
# fi

# install weston
cd $1
git checkout 11.0
meson setup build && ninja -C build
sudo ninja -C build install