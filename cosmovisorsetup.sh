#!/bin/sh
# Get Cosmovisor
go get github.com/cosmos/cosmos-sdk/cosmovisor/cmd/cosmovisor

# Export Variables
export DAEMON_NAME=$BINARY_NAME
export DAEMON_HOME=$HOME/$BINARY_FOLDER
source ~/.profile

# Setup folders
mkdir -p $DAEMON_HOME/cosmovisor/genesis/bin
mkdir -p $DAEMON_HOME/cosmovisor/upgrades

# Copy Genesis to Cosmovisor

cp /home/$USER/go/bin/$BINARY_NAME $DAEMON_HOME/cosmovisor/genesis/bin
  
# Setup Cosmovisor Service
sudo nano /etc/systemd/system/cosmovisor.service

# Configure variables
[Unit]
Description=cosmovisor
After=network-online.target

[Service]
User=$USER
ExecStart=/home/$USER/go/bin/cosmovisor start
Restart=always
RestartSec=3
LimitNOFILE=4096
Environment="DAEMON_NAME=$BINARY_NAME"
Environment="DAEMON_HOME=/home/$USER/$BINARY_FOLDER"
Environment="DAEMON_ALLOW_DOWNLOAD_BINARIES=false"
Environment="DAEMON_RESTART_AFTER_UPGRADE=true"
Environment="DAEMON_LOG_BUFFER_SIZE=512"
Environment="UNSAFE_SKIP_BACKUP=true"

[Install]
WantedBy=multi-user.target
