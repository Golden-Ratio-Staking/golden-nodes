#!bin/sh

# Clean up old docker
sudo apt-get remove docker docker-engine docker.io containerd runc

# Get Update
sudo apt-get update

# Set Up Repository
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Get Docker official GPG Key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Get Docker Stable
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
 
# Check if Docker Works
sudo docker run hello-world
 
# Download Latest from BinaryHoldings
sudo docker pull ghcr.io/binaryholdings/tenderseed:latest

# Clone Repository
git clone https://github.com/binaryholdings/tenderseed

# Enter folder and Make tenderseed, copy binary to go bin
cd tenderseed
make
cp ~/tenderseed/build/tenderseed ~/go/bin

# Make Service File
sudo tee /etc/systemd/system/tenderseed.service > /dev/null <<EOF
[Unit]
Description=tenderseed
After=network-online.target
[Service]
User=admin
ExecStart=/home/admin/go/bin/tenderseed start
Restart=always
RestartSec=3
LimitNOFILE=4096
[Install]
WantedBy=multi-user.target
EOF

# Start Tenderseed. It will fail, but your config.toml file will be created.
tenderseed start

# Config Tenderseed to your liking...
sudo nano ~/.tenderseed/config/config.toml
