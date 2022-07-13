#!bin/bash

# Set Threshold
echo "export THRESHOLD=3" | sudo tee -a $HOME/.profile

# Set Horcrux Signer IPs in Profile
# Change these to your horcrux signer IPs. Feel free to add/remove as necessary.
echo "export HORCRUX_1=X.X.X.X" | sudo tee -a $HOME/.profile
echo "export HORCRUX_2=X.X.X.X" | sudo tee -a $HOME/.profile
echo "export HORCRUX_3=X.X.X.X" | sudo tee -a $HOME/.profile
echo "export HORCRUX_4=X.X.X.X" | sudo tee -a $HOME/.profile
echo "export HORCRUX_5=X.X.X.X" | sudo tee -a $HOME/.profile

# Peers/Swarm of Sentry/Full Nodes. Please complete with your own information/IPs/custom ports. 
# You can/should list multiple, if you have them, as shown in first example.
echo "export ATOM_SWARM=tcp://X.X.X.X:16231,tcp://X.X.X.X:16231,tcp://X.X.X.X:16231" | sudo tee -a $HOME/.profile
echo "export BCNA_SWARM=tcp://X.X.X.X:16182" | sudo tee -a $HOME/.profile
echo "export CMDX_SWARM=tcp://X.X.X.X:16241" | sudo tee -a $HOME/.profile
echo "export CRBRUS_SWARM=tcp://X.X.X.X:16234" | sudo tee -a $HOME/.profile
echo "export DIG_SWARM=tcp://X.X.X.X:16235" | sudo tee -a $HOME/.profile
echo "export EVMOS_SWARM=tcp://X.X.X.X:16237" | sudo tee -a $HOME/.profile
echo "export HUAHUA_SWARM=tcp://X.X.X.X:16233" | sudo tee -a $HOME/.profile
echo "export JUNO_SWARM=tcp://X.X.X.X:16238" | sudo tee -a $HOME/.profile
echo "export KUJI_SWARM=tcp://X.X.X.X:16231" | sudo tee -a $HOME/.profile
echo "export NGM_SWARM=tcp://X.X.X.X:16236" | sudo tee -a $HOME/.profile
echo "export NOM_SWARM=tcp://X.X.X.X:16239" | sudo tee -a $HOME/.profile
echo "export OSMO_SWARM=tcp://X.X.X.X:16240" | sudo tee -a $HOME/.profile

# Cosmos Chain-IDs. No need to update these, unless you need to add an additional chain, or if I missed a hard fork. Trust, but verify to save yourself the headache.
echo "export ATOM_CHAINID=cosmoshub-4" | sudo tee -a $HOME/.profile
echo "export BCNA_CHAINID=bitcanna-1" | sudo tee -a $HOME/.profile
echo "export CMDX_CHAINID=comdex-1" | sudo tee -a $HOME/.profile
echo "export CRBRUS_CHAINID=cerberus-chain-1" | sudo tee -a $HOME/.profile
echo "export DIG_CHAINID=dig-1" | sudo tee -a $HOME/.profile
echo "export EVMOS_CHAINID=evmos_9001-2" | sudo tee -a $HOME/.profile
echo "export HUAHUA_CHAINID=chihuahua-1" | sudo tee -a $HOME/.profile
echo "export JUNO_CHAINID=juno-1" | sudo tee -a $HOME/.profile
echo "export KUJI_CHAINID=kaiyo-1" | sudo tee -a $HOME/.profile
echo "export NGM_CHAINID=emoney-3" | sudo tee -a $HOME/.profile
echo "export NOM_CHAINID=nomic-stakenet-3" | sudo tee -a $HOME/.profile
echo "export OSMO_CHAINID=osmosis-1" | sudo tee -a $HOME/.profile

# Welcome Back, please see custom ports below.
# Priv_Validator_Laddr custom ports, so that you can run multiple horcrux signers at once without conflict.
# Feel free to change if you must/prefer.
echo "export ATOM_PORT=1618" | sudo tee -a $HOME/.profile
echo "export BCNA_PORT=1619" | sudo tee -a $HOME/.profile
echo "export CMDX_PORT=1620" | sudo tee -a $HOME/.profile
echo "export CRBRUS_PORT=1621" | sudo tee -a $HOME/.profile
echo "export DIG_PORT=1622" | sudo tee -a $HOME/.profile
echo "export EVMOS_PORT=1623" | sudo tee -a $HOME/.profile
echo "export HUAHUA_PORT=1624" | sudo tee -a $HOME/.profile
echo "export JUNO_PORT=1625" | sudo tee -a $HOME/.profile
echo "export KUJI_PORT=1626" | sudo tee -a $HOME/.profile
echo "export NGM_PORT=1627" | sudo tee -a $HOME/.profile
echo "export NOM_PORT=1628" | sudo tee -a $HOME/.profile
echo "export OSMO_PORT=1629" | sudo tee -a $HOME/.profile

# Source profile so it sticks
source ~/.profile

# Get Horcrux
wget https://github.com/strangelove-ventures/horcrux/releases/download/v2.0.0-rc3/horcrux_2.0.0-rc3_linux_amd64.tar.gz
tar -xzf horcrux_2.0.0-rc3_linux_amd64.tar.gz
sudo mv horcrux /usr/bin/horcrux && rm horcrux_2.0.0-rc3_linux_amd64.tar.gz README.md LICENSE.md
