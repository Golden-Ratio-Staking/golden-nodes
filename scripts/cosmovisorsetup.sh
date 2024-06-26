#!/bin/sh
# Get Cosmovisor
go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@latest

# Set up folders and place binary in genesis bin
cosmovisor init $HOME/go/bin/$DAEMON_NAME

# Setup folders
# mkdir -p $DAEMON_HOME/cosmovisor/genesis/bin
# mkdir -p $DAEMON_HOME/cosmovisor/upgrades

# Place Binary in Folder
# cp /home/$USER/go/bin/$DAEMON_NAME $DAEMON_HOME/cosmovisor/genesis/bin

# Setup Cosmovisor Service
# There's a better way to do this, but this works just fine...

echo "[Unit]" | sudo tee -a /etc/systemd/system/cosmovisor.service
echo "Description=cosmovisor" | sudo tee -a /etc/systemd/system/cosmovisor.service
echo "After=network-online.target" | sudo tee -a /etc/systemd/system/cosmovisor.service
echo "[Service]" | sudo tee -a /etc/systemd/system/cosmovisor.service
echo "User=$USER" | sudo tee -a /etc/systemd/system/cosmovisor.service
echo "ExecStart=$HOME/go/bin/cosmovisor run start" | sudo tee -a /etc/systemd/system/cosmovisor.service
echo "Restart=always" | sudo tee -a /etc/systemd/system/cosmovisor.service
echo "RestartSec=8" | sudo tee -a /etc/systemd/system/cosmovisor.service
echo "LimitNOFILE=infinity" | sudo tee -a /etc/systemd/system/cosmovisor.service
echo "Environment="DAEMON_NAME=$DAEMON_NAME"" | sudo tee -a /etc/systemd/system/cosmovisor.service
echo "Environment="DAEMON_HOME=$DAEMON_HOME"" | sudo tee -a /etc/systemd/system/cosmovisor.service
echo "Environment="DAEMON_ALLOW_DOWNLOAD_BINARIES=false"" | sudo tee -a /etc/systemd/system/cosmovisor.service
echo "Environment="DAEMON_RESTART_AFTER_UPGRADE=true"" | sudo tee -a /etc/systemd/system/cosmovisor.service
echo "Environment="DAEMON_LOG_BUFFER_SIZE=512"" | sudo tee -a /etc/systemd/system/cosmovisor.service
echo "Environment="DAEMON_SHUTDOWN_GRACE=10s"" | sudo tee -a /etc/systemd/system/cosmovisor.service
echo "Environment="DAEMON_RESTART_DELAY=10s"" | sudo tee -a /etc/systemd/system/cosmovisor.service
echo "Environment="UNSAFE_SKIP_BACKUP=true"" | sudo tee -a /etc/systemd/system/cosmovisor.service
echo "[Install]" | sudo tee -a /etc/systemd/system/cosmovisor.service
echo "WantedBy=multi-user.target" | sudo tee -a /etc/systemd/system/cosmovisor.service
