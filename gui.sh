#!/bin/sh
sudo apt-get update && sudo apt-get upgrade -y
sudo apt upgrade -y
sudo apt install xrdp -y
sudo systemctl enable xrdp
sudo apt install build-essential -y
sudo apt-get install tasksel -y
sudo apt-get install lightdm -y
sudo tasksel
sudo nano /etc/default/grub
sudo update-grub
sudo apt-get update -y && apt-get upgrade -y
reboot
