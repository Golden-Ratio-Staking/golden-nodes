#!bin/bash

# Make Horcrux Service File
echo "[Unit]" | sudo tee -a /etc/systemd/system/horcrux-bcna.service
echo "Description=Horcrux-BCNA" | sudo tee -a /etc/systemd/system/horcrux-bcna.service
echo "After=network.target" | sudo tee -a /etc/systemd/system/horcrux-bcna.service
echo " " | sudo tee -a /etc/systemd/system/horcrux-bcna.service
echo "[Service]" | sudo tee -a /etc/systemd/system/horcrux-bcna.service
echo "Type=simple" | sudo tee -a /etc/systemd/system/horcrux-bcna.service
echo "User=$USER" | sudo tee -a /etc/systemd/system/horcrux-bcna.service
echo "WorkingDirectory=/home/$USER" | sudo tee -a /etc/systemd/system/horcrux-bcna.service
echo "ExecStart=/usr/bin/horcrux cosigner start" | sudo tee -a /etc/systemd/system/horcrux-bcna.service
echo "Restart=always" | sudo tee -a /etc/systemd/system/horcrux-bcna.service
echo "RestartSec=10" | sudo tee -a /etc/systemd/system/horcrux-bcna.service
echo "LimitNOFILE=infinity" | sudo tee -a /etc/systemd/system/horcrux-bcna.service
echo " " | sudo tee -a /etc/systemd/system/horcrux-bcna.service
echo "[Install]" | sudo tee -a /etc/systemd/system/horcrux-bcna.service
echo "WantedBy=multi-user.target" | sudo tee -a /etc/systemd/system/horcrux-bcna.service

sudo systemctl daemon-reload

# horcrux config init chain-id "Sentry Node IPs" -c(cosigners) -p(signer peers) -l(listen address for main signer) -t(threshold) --timeout
horcrux config init $BCNA_CHAINID "$BCNA_SWARM" -c -p "tcp://$HORCRUX_2:$BCNA_PORT|2,tcp://$HORCRUX_3:$BCNA_PORT|3,tcp://$HORCRUX_4:$BCNA_PORT|4,tcp://$HORCRUX_5:$BCNA_PORT|5" -l "tcp://$HORCRUX_1:$BCNA_PORT" -t $THRESHOLD --timeout 1618ms
