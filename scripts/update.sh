#!bin/bash

# Remove the bloat
sudo apt autoremove -y

# Purge old Linux Kernels
sudo apt purge -y $(sudo dpkg --list linux-{headers,image,modules}-\* \
| awk '{ if ($1=="ii") print $2}' \
| egrep '[0-9]+\.[0-9]+\.[0-9]+-[0-9]+' \
| egrep -v $(uname -r | cut -d"-" -f1,2))

# Fix the complaining installs that couldn't finish
sudo apt --fix-broken install

# Update grub
sudo update-grub

# Update packages
sudo apt update && sudo apt upgrade -y 
