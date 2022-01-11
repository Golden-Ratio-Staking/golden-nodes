#!/bin/sh
# Get Cosmovisor
go get github.com/cosmos/cosmos-sdk/cosmovisor/cmd/cosmovisor

# Setup folders
mkdir -p $DAEMON_HOME/cosmovisor/genesis/bin
mkdir -p $DAEMON_HOME/cosmovisor/upgrades

# Copy Genesis to Cosmovisor

cp /home/$USER/go/bin/$BINARY_NAME $DAEMON_HOME/cosmovisor/genesis/bin
  
# Setup Cosmovisor Service
sudo nano /etc/systemd/system/cosmovisor.service
