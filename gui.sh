#!/bin/sh
sudo apt-get update && sudo apt-get upgrade -y
sudo apt upgrade -y
sudo apt install build-essential -y
sudo apt-get install tasksel -y
sudo apt-get install lightdm -y
sudo tasksel
reboot
