#!/bin/sh
sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt upgrade -y
sudo apt install xfce4 xfce4-goodies xorg dbus-x11 x11-xserver-utils -y
sudo apt install xrdp -y
sudo adduser xrdp ssl-cert
sudo systemctl enable xrdp
sudo systemctl restart xrdp
sudo apt-get install tasksel -y
sudo apt-get install lightdm -y
sudo tasksel
sudo reboot
