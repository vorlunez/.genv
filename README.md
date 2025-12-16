# Ubuntu installation & configuration & VMware installtion

## 1. download Ubuntu
### Ubuntu 20.04
server: https://releases.ubuntu.com/20.04/ubuntu-20.04.6-live-server-amd64.iso

desktop: https://releases.ubuntu.com/20.04/ubuntu-20.04.6-desktop-amd64.iso

### Ubuntu 22.04
server: https://releases.ubuntu.com/22.04/ubuntu-22.04.5-live-server-amd64.iso

desktop: https://releases.ubuntu.com/22.04/ubuntu-22.04.5-desktop-amd64.iso

### Ubuntu 24.04
server: https://releases.ubuntu.com/24.04/ubuntu-24.04.2-live-server-amd64.iso

desktop: https://releases.ubuntu.com/24.04/ubuntu-24.04.2-desktop-amd64.iso

## 2. make Ubuntu installation USB drive in Ubuntu

```bash
lsblk # find usb drive like /dev/sda
unmount sdx
sudo dd if=/path/to/ubuntu.iso of=/dev/sdX bs=4M status=progress # write it
```

## 3. install Ubuntu
reboot and press F2 to enter boot configuration and choose usb drive as first option

## 4. Configure Ubuntu
```bash
source install.sh
```

## 5. install VMware
```bash
wget https://softwareupdate.vmware.com/cds/vmw-desktop/ws/17.6.3/24583834/linux/core/VMware-Workstation-17.6.3-24583834.x86_64.bundle.tar
tar -xvf VMware-Workstation-17.6.3-24583834.x86_64.bundle.tar
chmod +x VMware-Workstation-17.6.3-24583834.x86_64.bundle
sudo ./VMware-Workstation-17.6.3-24583834.x86_64.bundle
```

## 6. fix (Could not open /dev/vmmon: No such file or directory)

save following content to a script and execute it
```bash
#!/bin/bash

filename_key="vmware_key"
sudo openssl req -new -x509 -newkey rsa:2048 -keyout ${filename_key}.priv -outform DER -out ${filename_key}.der -nodes -days 36500 -subj "/CN=VMware/"
sudo /usr/src/linux-headers-`uname -r`/scripts/sign-file sha256 ./${filename_key}.priv ./${filename_key}.der $(modinfo -n vmmon)
sudo /usr/src/linux-headers-`uname -r`/scripts/sign-file sha256 ./${filename_key}.priv ./${filename_key}.der $(modinfo -n vmnet)
sudo mokutil --import ${filename_key}.der 
echo "Now it's time for reboot, remember the password. You will get a blue screen after reboot choose 'Enroll MOK' -> 'Continue' -> 'Yes' -> 'enter password' -> 'OK' or 'REBOOT' " 
```
OKOK
