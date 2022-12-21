#!/bin/sh
# sudo no password
echo "$USER ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers

# update the local package list and install any available upgrades
cd $HOME 
cd golden-nodes/scripts
echo "***Updating...***"
sleep 2
bash update.sh
echo " "
echo "***Update complete***"

# Copy convenience home
echo " "
sleep 1
echo "***Copying scripts to home...***"
echo " "
sleep 1
cp ban.sh $HOME
cp consensus.sh $HOME
cp editvalidator.sh $HOME
cp gov.sh $HOME
cp restart_cosmovisor.sh $HOME
cp update.sh $HOME
echo "***done***"

# Install toolchain and ensure accurate time synchronization
echo " "
sleep 1
echo "***Installing toolchain to smoothly run nodes...***"
echo " "
sleep 3
sudo apt install curl tar wget pkg-config libssl-dev jq build-essential git make ncdu -y
sudo apt-get install -y make gcc
echo "***done***"

# Install Golang (Go)
ver="1.19.2"
echo " "
sleep 1
echo "***Installing Go "$VER"...***"
echo " "
sleep 2

cd $HOME
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz"
rm "go$ver.linux-amd64.tar.gz"
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.profile
source $HOME/.profile
echo "***done***"

# Install htop for viewing resources
echo " "
sleep 1
echo "***Installing htop...***"
echo " "
sleep 2
sudo apt install htop
echo "***done***"

# Install GEX for viewing chain status in a pretty way
echo " "
sleep 1
echo "***Installing GEX...***"
echo " "
sleep 2
go install github.com/cosmos/gex@latest
echo "***done***"

# Install Tree so you can look at what files you have in a pretty way
echo " "
sleep 1
echo "***Installing tree...***"
echo " "
sleep 2
sudo apt install tree
echo "***done***"

# Snapshot Tooling, particularly helpful with Polkachu Snapshots
echo " "
sleep 1
echo "***Installing snapshot tooling...***"
echo " "
sleep 2
sudo apt install snapd -y
sudo snap install lz4
echo "***done***"

# Install Net-Tools
echo " "
sleep 1
echo "***Installing Net-Tools...***"
echo " "
sleep 2
sudo apt install net-tools
echo "***done***"

# Install Speedtest
echo " "
sleep 1
echo "***Installing Speedtest...***"
echo " "
sleep 2
sudo apt install speedtest-cli -y
echo "***done***"

# Install grpcurl
echo " "
sleep 1
echo "***Installing grpcurl...***"
echo " "
sleep 2
go install github.com/fullstorydev/grpcurl/cmd/grpcurl@latest
echo "***done***"

# Make 16G Swap File
echo " "
sleep 1
echo "***Creating 16GB swap file...***"
echo " "
sleep 2
sudo swapoff -a
sudo fallocate -l 16G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile


# Make Swap File persist even after a reboot
sudo cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
echo "***done***"

# Set timezone to UTC becauase you're an adult
echo " "
sleep 1
echo "***Setting timezone to UTC because you're an adult...***"
echo " "
sleep 2
sudo timedatectl set-timezone UTC
echo "***done***"

# Setup UFW to allow only SSH and tendermint P2P
echo " "
sleep 1
echo "***Setting up firewall (don't worry, ssh/tcp will be open so you don't get locked out)...***"
echo " "
sleep 3
sudo apt install ufw -y
sudo ufw status
sudo ufw allow ssh/tcp
sudo ufw allow 26656
echo "***done***"

# Setup fail2ban
echo " "
sleep 1
echo "***Setting up fail2ban...***"
echo " "
sleep 2
cd $HOME
sudo apt install fail2ban -y
sudo systemctl enable fail2ban
sleep 5
sudo systemctl restart fail2ban
echo "***done***"

# Remove Unattended-Upgrades
echo " "
sleep 1
echo "***Getting rid of unattended upgrades because randomly restarting nodes in middle of the night is wack...***"
echo " "
sleep 3
sudo systemctl stop unattended-upgrades
sudo systemctl disable unattended-upgrades
sudo apt purge unattended-upgrades -y
echo "***done***"

# Get Consensus Watcher
echo " "
sleep 1
echo "***Installing consensus watcher. ty Blockpane <3***"
echo " "
sleep 2
cd $HOME
git clone https://github.com/joeabbey/pvtop
cd pvtop
git checkout show-commits-too
go install
echo "***done***"

# Reboot to clear things up
echo " "
sleep 1
echo "***Reebooting...be back in a little bit <3***"
echo " "
sleep 2
sudo reboot
