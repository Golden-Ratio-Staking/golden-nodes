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
sudo nano /etc/systemd/system/cosmovisor.service
