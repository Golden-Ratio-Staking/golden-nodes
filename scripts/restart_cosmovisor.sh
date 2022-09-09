#!bin/bash

# Stop Cosmovisor
echo "Stopping Cosmovisor...$(date +"%r")"
sudo systemctl stop cosmovisor
sleep 1

# Miss miss a block or 2, you'll be fine.
echo " "
echo "Cosmovisor Stopped. Sleeping for ~1 Block...$(date +"%r")"
sleep 10

# Restart Cosmovisor
echo " "
echo "Restarting Cosmovisor...$(date +"%r")"
sudo systemctl restart cosmovisor && journalctl -u cosmovisor -fo cat
