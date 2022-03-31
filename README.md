# Node-Creation
## Quick GUI and Node Creation

### Add User, Remove Root Passwd, Reboot
```
adduser <Pick a Name>
passwd -d root
```

### Change Computer Name for ID purposes
```
sudo nano /etc/hostname
sudo nano /etc/hosts
reboot
```
### Login with newly created user

### Get .git (If Necessary)
`sudo apt install git -y`

### Server Setup, will automatically reboot at the end
```
git clone https://github.com/Golden-Ratio-Staking/Node-Creation
cd Node-Creation
bash serversetup.sh
```

### Configure Go Path (unless `go version` works)
```
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export GO111MODULE=on
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
source ~/.profile
```

### Get Gex
`go get -u github.com/cosmos/gex`

## Now, go install whatever chain you're going to run or use script to spin up quickly.

## If regularly installing witout script, `init` Chain to get config/app.toml and configure appropriately
## Download Genesis

### Configure/Export to profile and source
```
export DAEMON_NAME=<Daemon Name>
export DAEMON_HOME=<Daemon Folder>
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
Environment="DAEMON_NAME=<Daemon_Name>"
Environment="DAEMON_HOME=/home/admin/<daemon_folder>"
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
journalctl -u cosmovisor -f -o cat
```

### Service Route
#### Create a `/etc/systemd/system/<chain-name>.service` file:

```
[Unit]
Description=<Binary/Chain>
After=network-online.target

[Service]
User=<your-user>
ExecStart=/home/<your-user>/go/bin/<binary folder> start
Restart=always
RestartSec=3
LimitNOFILE=4096

[Install]
WantedBy=multi-user.target
```

### Go Variables for new shell use
```
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export GO111MODULE=on
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
source ~/.profile
```
