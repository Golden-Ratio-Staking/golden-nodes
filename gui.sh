#!/bin/sh
sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt upgrade -y
sudo apt install xrdp -y
sudo systemctl enable xrdp
sudo apt-get install tasksel -y
sudo apt-get install lightdm -y
sudo tasksel
reboot
