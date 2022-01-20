#!/bin/sh

# update the local package list and install any available upgrades
sudo apt-get update - && sudo apt upgrade -y

# Install Remote Desktop
sudo apt install xrdp -y
sudo systemctl enable xrdp

# Install Nautilus
sudo apt-get update
sudo apt install seahorse-nautilus -y
sudo nautilus -q

# update the local package list and install any available upgrades
sudo apt-get update && sudo apt upgrade -y

# Install toolchain and ensure accurate time synchronization
sudo apt install curl tar wget pkg-config libssl-dev jq build-essential git make ncdu -y

# Install Golang (Go)
wget https://golang.org/dl/go1.17.5.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.17.5.linux-amd64.tar.gz

sudo reboot
