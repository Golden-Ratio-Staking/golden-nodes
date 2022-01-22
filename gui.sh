#!/bin/sh
sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt-get install tasksel -y
sudo apt-get install lightdm -y
sudo tasksel
sudo reboot
