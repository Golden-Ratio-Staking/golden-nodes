# Node-Creation
## Quick GUI and Node Creation

### Get .git (If Necessary)
`sudo apt-get git -y`

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
BINARY_NAME=?
BINARY_FOLDER=?
```
source ~/.profile
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
User=admin
ExecStart=/home/admin/go/bin/cosmovisor start
Restart=always
RestartSec=3
LimitNOFILE=4096
Environment="DAEMON_NAME=$BINARY_NAME"
Environment="DAEMON_HOME=/home/admin/$BINARY_FOLDER"
Environment="DAEMON_ALLOW_DOWNLOAD_BINARIES=false"
Environment="DAEMON_RESTART_AFTER_UPGRADE=true"
Environment="DAEMON_LOG_BUFFER_SIZE=512"
Environment="UNSAFE_SKIP_BACKUP=true"

[Install]
WantedBy=multi-user.target
```

### Start Cosmovisor
```
sudo -S systemctl daemon-reload
sudo -S systemctl enable cosmovisor
sudo systemctl start cosmovisor
journalctl -u cosmovisor -f
```

### Go Variables for new shell use
```
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export GO111MODULE=on
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
source ~/.profile
```
