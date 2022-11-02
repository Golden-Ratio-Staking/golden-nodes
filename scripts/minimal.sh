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
cp update.sh $HOME
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
