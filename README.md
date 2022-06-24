## Tendermint Based Chain - Node Creation 101
This guide is a begginer intro to Linux creation and setting up a node for a Tendermint based chain. Many features and security advances can & should be actioned upon, however this is a barebones walkthrough to get setup from scratch. There are scripts and ansible playbooks to set up entire nodes with a few clicks, but if you'd like to learn how to set up manually, this is it. You will see `<something>` throughout this tutorial, these are for you to change yourself for rememberance and uniformity. Change the letters and then remove these symbols `<>`.

You will need to start with getting a Server/VPS from OVHcloud, Vultr, Hetzner, Contabo, etc. You can set up a lot from within, including using SSH keys and firewall configurations. However, we're going to pretend you simply just installed a fresh Ubuntu 20.04 HWE LTS and got your Password for `root` emailed to you...so let's change that...

#### Add your username (then follow prompts to add your new, personal password) and Remove Root Password
```
adduser <Pick a Name>
passwd -d root 
```

#### Change Computer Name for ID purposes, something like `CoolNewChain-Validator`
```
sudo nano /etc/hostname
sudo nano /etc/hosts
reboot
```

#### Login with newly created user
#### Update Linux Dependencies and Install Git
```bash
sudo apt update
sudo apt install git -y
```

Server Setup. This script has a bunch of goodies to make your node run smoothly and nicely with most (like 99.9%) of Tendermint based chains. It is downloading from this repository, so feel free to look at the code/script yourself and pick/choose which pieces to install if you'd like to be picky. Last step of script is to `reboot` like every good install of a bunch of new programs, so don't panic when you see a `"Disconnected from Host!"` banner pop up. It will be avaible again in a few minutes.
```bash
git clone https://github.com/Golden-Ratio-Staking/GoldenRatioNodes
cd GoldenRatioNodes/scripts
bash serversetup.sh
```

# STOP
Go install whatever chain you're going to run, or use script to spin up quickly. If regularly installing witout script, `init` Chain to get `app.toml`, `client.toml`, `config.toml` and configure appropriately. Using JUNO or Osmosis startup guides can be very helpful for practice as they are top notch in explanations.


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

This script will set you up with latest Cosmovisor, configure folders, and copy your Binary to Genesis folder, the last step of script will place you into the service file for Cosmovisor (so a blank screen until you copy/paste template)
```bash
cd $HOME
cd GoldenRatioNodes/scripts
bash cosmovisorsetup.sh
```
Once script is finished, you should be seeing a blank screen within `nano`, which will be your future service file. Copy/Paste/Edit this service file as needed (pay attention to `<these>`). Then press `Ctrl+X` to escape, `y` to save, and `enter` to confirm.

Cosmovisor Service Template (if you want to edit it in the future simply enter `sudo nano /etc/systemd/system/cosmovisor.service`
```
[Unit]
Description=cosmovisor
After=network-online.target

[Service]
User=<username>
ExecStart=/home/<username>/go/bin/cosmovisor start
Restart=always
RestartSec=3
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

Start Cosmovisor. This will refresh service file, enable service file to restart itself upon startup/restart of the server, and start the chain.
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
RestartSec=3
LimitNOFILE=4096

[Install]
WantedBy=multi-user.target
```
