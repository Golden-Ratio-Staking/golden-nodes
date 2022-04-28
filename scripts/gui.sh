#!/bin/sh
sudo apt update && sudo apt upgrade -y
sudo apt-get install tasksel -y
sudo apt-get install lightdm -y
sudo tasksel
sudo reboot
