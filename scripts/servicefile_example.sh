#!bin/bash

# Setup simple service file. Edit with sudo nano /etc/systemd/system/sample.service
# There's a better way to do this, but this works just fine...

echo "[Unit]" | sudo tee -a /etc/systemd/system/sample.service
echo "Description=sample" | sudo tee -a /etc/systemd/system/sample.service
echo "After=network-online.target" | sudo tee -a /etc/systemd/system/sample.service
echo "[Service]" | sudo tee -a /etc/systemd/system/sample.service
echo "User=$USER" | sudo tee -a /etc/systemd/system/sample.service
echo "ExecStart=$HOME/go/bin/sample run start" | sudo tee -a /etc/systemd/system/sample.service
echo "Restart=always" | sudo tee -a /etc/systemd/system/sample.service
echo "RestartSec=8" | sudo tee -a /etc/systemd/system/sample.service
echo "LimitNOFILE=infinity" | sudo tee -a /etc/systemd/system/sample.service
echo "[Install]" | sudo tee -a /etc/systemd/system/sample.service
echo "WantedBy=multi-user.target" | sudo tee -a /etc/systemd/system/sample.service
