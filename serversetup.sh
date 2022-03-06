#!/bin/sh
# update the local package list and install any available upgrades
sudo apt-get update && sudo apt upgrade -y

# Install Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb

# Install Remote Desktop and Interface
sudo apt install xfce4 xfce4-goodies xorg dbus-x11 x11-xserver-utils -y
sudo apt install xubuntu-desktop x2goserver x2goserver-xsession -y
sudo apt install xrdp -y
sudo adduser xrdp ssl-cert
sudo systemctl enable xrdp
sudo systemctl restart xrdp

# Install .deb installer
sudo apt install gdebi -y

# Install Nautilus
sudo apt-get update
sudo apt install seahorse-nautilus -y
sudo nautilus -q

# Install toolchain and ensure accurate time synchronization
sudo apt install curl tar wget pkg-config libssl-dev jq build-essential git make ncdu -y

# Install Golang (Go)
wget https://golang.org/dl/go1.17.5.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.17.5.linux-amd64.tar.gz

# Install htop
sudo apt install htop

# Install Tree
sudo apt install tree

# Snapshot Tooling
sudo apt install snapd
sudo snap install lz4

# Reboot
sudo reboot
