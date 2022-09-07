# Tendermint Based Chain - Node Creation 101
This guide is a beginner's intro to Linux creation and setting up a node for a Tendermint based chain. Many features and security advances can (& should) be done, however this is a barebones walkthrough to get setup from scratch. There are scripts and ansible playbooks to set up entire nodes with a few clicks, but if you'd like to learn how to set up manually, this is it. 

Throughout this guide, you will see notations like this--> `<something>`, these are for you to change to whatever you want...ideally something easy to remember, or consistent with other documentation. Change the letters and then remove these symbols `<>`.

You will need to start with getting a Dedicated Server/VPS from OVH, Vultr, ~~Hetzner~~, Contabo, etc. You can set up a lot from within, including using SSH keys and firewall configurations. However, we're going to pretend you simply just installed a fresh Ubuntu 20.04 HWE LTS and got your Password for `root` emailed to you...so let's change that...immediately.

## Make it personal...
Add your new username, this is what you will login with instead of `root`. There will be a series of informative questions, feel free to press enter until those are gone. After you've entered your new personal password, you'll remove the password for `root` effectively making it inaccessible, which is good since that is an easy target to try and brute force hack.
```bash
# Make your new username and add password
adduser <Pick a Name>

# Remove password from root
passwd -d root 
```

Change Computer Name for ID purposes, something like `CoolNewChain-Validator`, then Reboot to see changes in effect.
```
sudo nano /etc/hostname
sudo nano /etc/hosts
reboot
```

## Setup Time
Login with newly created user, then start setting up
```bash
# Update Linux Dependencies
sudo apt update

# Install Git so you can be useful
sudo apt install git -y
```

Server Setup. This script has a bunch of goodies to make your node run smoothly and nicely with most (like 99.9%) of Tendermint based chains. It is downloading from this repository, so feel free to look at the code/script yourself and pick/choose which pieces to install if you'd like to be picky. Last step of script is to `reboot` like every good install of a bunch of new programs, so don't panic when you see a `"Disconnected from Host!"` banner pop up. It will be avaible again in a few minutes.

Notable additional installs: `UFW` (with rules to allow SSH and 26656 for P2P) and `fail2ban`. Your security will be thankful later when you enable these later on. 
```bash
git clone https://github.com/Golden-Ratio-Staking/GoldenRatioNodes
cd GoldenRatioNodes/scripts
bash serversetup.sh
```

# STOP
- Go install whatever chain you're going to run, or use script to spin up quickly. 
- If regularly installing witout automated script, `init` Chain to get `app.toml`, `client.toml`, `config.toml` and configure appropriately. 
- Using JUNO or Osmosis startup guides can be very helpful for practice as they are top notch in explanations.

# Optional Extras, if the chain you're setting up left out some detail:

## Run node with Cosmovisor

This script will get you set up Cosmovisor, which will simplify your life with upgrades going forward:

1st, Set Variables into your `~/.profile` and `source` it.
```bash
export DAEMON_HOME=<Binary_Folder> >> $HOME/.profile
```
```bash
export DAEMON_NAME=<Binary_Name> >> $HOME/.profile
```
```bash
source $HOME/.profile
```

Note, this should be done *AFTER* installing chain binary. This script will set you up with latest Cosmovisor, configure folders, and copy your Binary to Genesis folder.
```bash
cd $HOME
cd GoldenRatioNodes/scripts
bash cosmovisorsetup.sh
```

Cosmovisor Service Template (if you want to edit it in the future simply enter `sudo nano /etc/systemd/system/cosmovisor.service`
```
[Unit]
Description=cosmovisor
After=network-online.target

[Service]
User=<username>
ExecStart=/home/<username>/go/bin/cosmovisor start
Restart=always
RestartSec=8
LimitNOFILE=infinity
Environment="DAEMON_NAME=<Binary_Name>"
Environment="DAEMON_HOME=/home/<username>/<Binary_Folder>"
Environment="DAEMON_ALLOW_DOWNLOAD_BINARIES=false"
Environment="DAEMON_RESTART_AFTER_UPGRADE=true"
Environment="DAEMON_LOG_BUFFER_SIZE=512"
Environment="UNSAFE_SKIP_BACKUP=true"

[Install]
WantedBy=multi-user.target
```

Start Cosmovisor. This will reload service file, enable service file to restart itself upon startup/restart of the server, and start the chain.
```bash
sudo -S systemctl daemon-reload
sudo -S systemctl enable cosmovisor
sudo systemctl start cosmovisor
journalctl -u cosmovisor -fo cat
```

## Run Node with Service File (AKA OG, AKA "I don't like Cosmovisor")

Simply ignore the entire cosmovior portion above and create a service file: 
```
sudo nano /etc/systemd/system/<chain-name>.service
```

Then copy/paste/edit to your heart's content
```
[Unit]
Description=<Binary/Chain>
After=network-online.target

[Service]
User=<username>
ExecStart=/home/<username>/go/bin/<Binary_Folder> start
Restart=always
RestartSec=8
LimitNOFILE=4096

[Install]
WantedBy=multi-user.target
```
