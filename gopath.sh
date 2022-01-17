#!bin/bash
wget https://golang.org/dl/go1.17.5.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.17.5.linux-amd64.tar.gz
echo "export GOROOT=/usr/local/go"
echo "export GOPATH=$HOME/go"
echo "export GO111MODULE=on"
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin"
echo "source ~/.profile"
