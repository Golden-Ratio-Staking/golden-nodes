#!/bin/sh
# Get Cosmovisor
go get github.com/cosmos/cosmos-sdk/cosmovisor/cmd/cosmovisor

# Setup folders
mkdir -p $DAEMON_HOME/cosmovisor/genesis/bin
mkdir -p $DAEMON_HOME/cosmovisor/upgrades

# Place Genisis Binary in Folder
cp /home/$USER/go/bin/junod $DAEMON_HOME/cosmovisor/genesis/bin

# Setup Cosmovisor Service
sudo nano /etc/systemd/system/cosmovisor.service
