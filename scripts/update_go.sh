#!/bin/bash

# Check for wget, we need it to download Go
if ! command -v wget &> /dev/null; then
    echo "Error: wget is required to download Go. Please install wget and try again."
    exit 1
fi

# Get the latest Go version number
GO_LATEST_VERSION=$(wget -qO- https://go.dev/dl/ | grep -oP 'go([0-9]+\.[0-9]+(\.[0-9]+)?)[^0-9]' | head -n 1)

# Check if the latest version is already installed
if command -v go &> /dev/null && go version | grep -q "$GO_LATEST_VERSION"; then
    echo "Go is already up to date ($GO_LATEST_VERSION)"
    exit 0
fi

# Download and install the latest Go version
ARCHIVE="${GO_LATEST_VERSION}linux-amd64.tar.gz"
DOWNLOAD_URL="https://golang.org/dl/${ARCHIVE}"

echo "Downloading Go $GO_LATEST_VERSION..."
wget -q --show-progress "$DOWNLOAD_URL"

# Remove previous Go installation
if [ -d "/usr/local/go" ]; then
    echo "Removing previous Go installation..."
    sudo rm -rf /usr/local/go
fi

echo "Installing Go $GO_LATEST_VERSION..."
sudo tar -C /usr/local -xzf "$ARCHIVE"
rm "$ARCHIVE"

# Add Go to the PATH if it's not already there
if ! grep -q 'export PATH=$PATH:/usr/local/go/bin' ~/.profile; then
    echo "Adding Go to PATH..."
    echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.profile
    source ~/.profile
fi

echo "Go $GO_LATEST_VERSION installed successfully!"
