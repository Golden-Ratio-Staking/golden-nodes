#!/bin/sh
sudo apt-get update && sudo apt-get upgrade -y
sudo apt install build-essential -y
sudo apt-get install tasksel -y
sudo tasksel
reboot
