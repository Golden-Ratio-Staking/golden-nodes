#!/bin/sh
# Get Cosmovisor, then upgrade it immediately to latest verison...you wont even notice
go install github.com/cosmos/cosmos-sdk/cosmovisor/cmd/cosmovisor@v1.0.0
go install github.com/cosmos/cosmos-sdk/cosmovisor/cmd/cosmovisor@v1.1.0

# Setup folders
mkdir -p $DAEMON_HOME/cosmovisor/genesis/bin
mkdir -p $DAEMON_HOME/cosmovisor/upgrades

# Place Binary in Folder
cp /home/$USER/go/bin/$DAEMON_NAME $DAEMON_HOME/cosmovisor/genesis/bin

# Setup Cosmovisor Service
USER=$(echo $USER | tee /dev/null)
DAEMON_HOME=$(echo $DAEMON_HOME | tee /dev/null)
DAEMON_NAME=$(echo $DAEMON_NAME | tee /dev/null)

sudo tee /etc/systemd/system/cosmovisor.service > /dev/null <<EOF
[Unit]
Description=cosmovisor
After=network-online.target

[Service]
User=$USER
ExecStart=$HOME/go/bin/$DAEMON_NAME start
Restart=always
RestartSec=3
LimitNOFILE=infinity
Environment="DAEMON_NAME=$DAEMON_NAME"
Environment="DAEMON_HOME=$DAEMON_HOME"
Environment="DAEMON_ALLOW_DOWNLOAD_BINARIES=false"
Environment="DAEMON_RESTART_AFTER_UPGRADE=true"
Environment="DAEMON_LOG_BUFFER_SIZE=512"
Environment="UNSAFE_SKIP_BACKUP=true"

[Install]
WantedBy=multi-user.target
EOF
