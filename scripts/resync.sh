#!/bin/bash

# Check if the required arguments are provided
if [ $# -ne 3 ]; then
  echo "Error: Please provide the snapshot URL, daemon name, and daemon home directory as command-line arguments."
  echo "Usage: $0 <snapshot_url> <daemon_name> <daemon_home>"
  exit 1
fi

snapshot_url=$1
daemon_name=$2
daemon_home=$3

# Extract the snapshot file name from the URL
snapshot_file=$(basename "$snapshot_url")

echo "Snapshot URL: $snapshot_url"
echo "Snapshot file: $snapshot_file"
echo "Daemon name: $daemon_name"
echo "Daemon home: $daemon_home"

# Extract the block number from the snapshot file name
block_number=$(echo $snapshot_file | grep -oE '[0-9]+')
echo "Block number: $block_number"

echo "Downloading snapshot using aria2c..."
# Download the snapshot using aria2c with more aggressive settings
if aria2c --max-connection-per-server=16 --split=16 --min-split-size=10M --max-concurrent-downloads=16 --max-overall-download-limit=0 --max-download-limit=0 -o "$snapshot_file" "$snapshot_url"; then
  echo "Snapshot downloaded successfully."
else
  echo "Error: Failed to download snapshot using aria2c. Please check the snapshot URL and try again."
  exit 1
fi

sleep 5

echo "Stopping $daemon_name daemon..."
# Stop the daemon
sudo systemctl stop "$daemon_name"
echo "$daemon_name daemon stopped."

sleep 5

echo "Resetting $daemon_name node..."
# Reset the node
"$daemon_name" tendermint unsafe-reset-all --home "$daemon_home" --keep-addr-book
echo "$daemon_name node reset."

sleep 5

echo "Removing existing wasm directory..."
# Remove the existing wasm directory
rm -r "${daemon_home}/wasm"
echo "Existing wasm directory removed."

sleep 5

echo "Extracting snapshot archive..."
# Extract the snapshot archive
if lz4 -c -d "$snapshot_file" | tar -x -C "$daemon_home"; then
  echo "Snapshot archive extracted successfully."
else
  echo "Error: Failed to extract snapshot archive. Exiting."
  exit 1
fi

sleep 5

echo "Removing downloaded snapshot file..."
# Remove the downloaded snapshot file
rm -v "$snapshot_file"
echo "Downloaded snapshot file removed."

sleep 5

echo "Restarting $daemon_name daemon..."
# Restart the daemon
sudo systemctl restart "$daemon_name"
echo "$daemon_name daemon restarted."

sleep 5

echo "Monitoring $daemon_name daemon logs..."
# Monitor the daemon logs
sudo journalctl -u "$daemon_name" -fo cat
