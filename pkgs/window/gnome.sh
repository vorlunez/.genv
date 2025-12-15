#!/bin/bash
URL=https://gitlab.gnome.org/GNOME

if [ -z $1 ];then
       echo "input target directory please"
       return 0
fi

if [ ! -d $1 ]; then
       echo "directory $1 not exist"
       return 0
fi

cd $1
meson_install() {
        git clone $URL/$1.git
        cd $1 && git checkout $2
        meson setup build
        ninja -C build
        sudo ninja -C build install
}
# for mutter
sudo apt install -y build-essential meson ninja-build libx11-dev libxcomposite-dev \
libxrandr-dev libxi-dev libxdamage-dev libxinerama-dev libxtst-dev libwayland-dev \
libinput-dev libudev-dev libevdev-dev libxcb-xinput-dev libxkbfile-dev libgles2-mesa-dev \
libdrm-dev wayland-protocols libstartup-notification0-dev libgnome-desktop-3-dev \
libglib2.0-dev gnome-settings-daemon-dev libgirepository1.0-dev libgtk-3-dev \
libgdk-pixbuf2.0-dev libcairo2-dev libjson-glib-dev libxkbcommon-x11-dev libxcb-randr0-dev \
libxcb-res0-dev xvfb libgraphene-1.0-dev libx11-xcb-dev libcanberra-dev libgbm-dev \
libpipewire-0.3-dev xwayland gettext x11-xserver-utils desktop-file-utils pkg-config \
libxml2-dev libical-dev libsqlite3-dev libssl-dev libgnomecanvas2-dev libdbus-1-dev xcvt
meson_install mutter gnome-42
export LD_LIBRARY_PATH=/usr/local/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH

# ERROR: Dependency "libecal-2.0" not found, tried pkgconfig and cmake
# install evolution-data-server
sudo apt install -y libkrb5-dev libnspr4-dev libnss3-dev gperf libsoup2.4-dev \
libwebkit2gtk-4.0-dev libgoa-1.0-devlibgcr-3-dev libsecret-1-dev libgweather-3-dev \
libgweather-3-16 libcanberra-gtk3-dev libgdata-dev
git clone $URL/evolution-data-server.git
cd evolution-data-server && git checkout gnome-42
mkdir -p build
cmake -S . -DWITH_OPENLDAP=OFF -DWITH_NSPR_INCLUDES=/usr/include/nspr -DWITH_NSS_INCLUDES=/usr/include/nss -B ./build
cmake --build ./build
sudo make -C ./build && sudo make -C ./build install

# ERROR: Dependency "gcr-4" not found, tried pkgconfig and cmake
sudo apt install -y libgtk-4-dev valac
pip install --user gi-docgen # maybe need add path to PATH
export PATH=$HOME/.local/bin:$PATH
meson_install gcr gnome-43

# for ERROR: Invalid version of dependency, need 'gio-2.0' ['>= 2.79.2'] found '2.72.4'.
sudo apt install -y libunwind-dev
meson_install glib glib-2-82

# ERROR: Dependency "gjs-1.0" not found, tried pkgconfig and cmake
sudo apt install -y libgjs-dev libpolkit-agent-1-dev libibus-1.0-dev libnm-dev \
asciidoctor asciidoc-base libpulse-dev libgnome-autoar-0-dev sassc
meson_install gjs gnome-42

# install gnome-shell
meson_install gnome-shell gnome-42

sudo apt install -y gnome-session gnome-settings-daemon dbus-x11 xorg

# terminal
sudo apt install -y gnome-terminal
mkdir -p ~/.config/autostart

echo "[Desktop Entry]
Name=GNOME Terminal
Exec=gnome-terminal
Type=Application
X-GNOME-Autostart-enabled=true" > ~/.config/autostart/gnome-terminal.desktop

sudo reboot