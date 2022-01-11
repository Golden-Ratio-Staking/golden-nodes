# Node-Creation
## Quick GUI and Node Creation

### Install GUI
```
git clone https://github.com/Golden-Ratio-Staking/Node-Creation
cd Node-Creation
bash gui.sh
```

### Once complete, favorite apps have been configured, and display adjusted:
```
cd Node-Creation
bash serversetup.sh
cd
```

### Now, download and install whatever chain you're going to be running

### Configure variables:
BINARY_NAME
BINARY_FOLDER
```
export DAEMON_NAME=$BINARY_NAME
export DAEMON_HOME=$HOME/$BINARY_FOLDER
source ~/.profile
```

### Setup Cosmovisor
```
cd Node-Creation
bash cosmovisorsetup.sh
```

### Cosmovisor Service Template
```
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
```
