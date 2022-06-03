#!/bin/sh
# update the local package list and install any available upgrades
sudo apt update && sudo apt upgrade -y

# Install Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb

# Install .deb installer
sudo apt install gdebi -y

# Install Nautilus
sudo apt install seahorse-nautilus -y
sudo nautilus -q

# Install toolchain and ensure accurate time synchronization
sudo apt install curl tar wget pkg-config libssl-dev jq build-essential git make ncdu -y
sudo apt-get install -y make gcc

# Install Golang (Go)
ver="1.18.3"
cd $HOME
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz"
rm "go$ver.linux-amd64.tar.gz"
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.profile
source $HOME/.profile

# Install htop for viewing resources
sudo apt install htop

# Install GEX for viewing chain status in a pretty way
go install github.com/cosmos/gex@latest

# Install Tree so you can look at what files you have in a pretty way
sudo apt install tree

# Snapshot Tooling, particularly helpful with Polkachu Snapshots
sudo apt install snapd
sudo snap install lz4

# Make 32G Swap File
sudo swapoff -a
sudo fallocate -l 64G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

# Make Swap File persist even after a reboot
sudo cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

# Reboot to clear things up
sudo reboot
