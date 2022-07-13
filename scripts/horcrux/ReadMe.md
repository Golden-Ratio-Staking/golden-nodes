# WORK IN PROGRESS
## Golden Ratio Staking Horcrux Setup
This script is an advanced and condensed version of the `mirgrating.md` provided by Strangelove-Ventures, please visit https://github.com/strangelove-ventures/horcrux/blob/main/docs/migrating.md for a much more detailed explanation. Without prior knowledge of how Horcrux works, or how configuration need to be, this condensed guide/script may lead you astray and into a world of confusion/problems that will require troubleshooting. I implore you to read the official docs before attmepting this. This script heavily utilizes shell variables that, once set, will make deploying on multiple chains much easier.

## Instructions

#### Setup ~/.profile
Edit `horcrux_bootstrap.sh` variables, specifically the signer IPs `"HORCRUX_X=X.X.X.X"`. There are a boatload of other variables related to `CHAIN_IDs` (probably doesn't need to be changed unless there's a fork I haven't accounted for) and `CHAIN_PORTS` (can, but doesn't have to be changed, as it is pre-configured to not conflict with running multiple chains per signer).
```
cd $HOME
cd GoldenRatioNodes/scripts/horcrux
sudo nano horcrux_bootstrap.sh
```

#### Initialize Horcrux
ATOM
BCNA
```
```
CHIHUAHUA
CMDX
CRBRBUS
DIG
EMONEY
EVMOS
JUNO
NOM
OSMO

#### Split up Private Key
This part will require some manual labor. You'll need your `priv_validator_key.json` for whatever chain you're about to start running. Keep security in mind when doing this. 

*MAKE SURE THE CORRECT KEY FRAGMENT GOES TO THE CORRECT CORRESPONDING NODE*
```
key share 1 -> horcrux 1
key share 2 -> horcrux 2
etc
```
*OR EVERYTHING WILL BREAK AND YOU'LL HATE YOURSELF FOR A SOLID FEW HOURS WHILE TROUBLESHOOTING*

To create your key fragments:
```
$ ls
priv_validator_key.json

$ horcrux create-shares priv_validator_key.json 2 3 4 5
Created Share 1
Created Share 2
Created Share 3

$ ls
priv_validator_key.json
private_share_1.json
private_share_2.json
private_share_3.json
private_share_4.json
private_share_5.json
```

## Start Migration
At this point, you should have a fully configured horcrux signer system, getting ready to talk to your swarm of sentries. There are still a few more steps left though. This step is copied, nearly verbatim, from the Original Docs.

### Halt your validator node and supply signer state data horcrux nodes
Now is the moment of truth. There will be a few minutes of downtime for this step, so ensure you have read the following directions completely before moving forward.

You need to take your validator offline and trust that the horcrux setup you have created is going to pick up signing for you soon. Ensure the validator is off and not signing.

NOTE: Leave your current validator turned off, but able to be restarted to resume signing in case of failure. When you are certain that the horcrux cluster is signing for you and your validator is back online it will be safe to decommission the old infrastructure.

Once the validator has been stopped, you will need the contents of the `$NODE_HOME/data/priv_validator_state.json` file. This file represents the last time your validator key was used to sign for consensus and acts as a "high water" mark to prevent your validator from doublesigning. Horcrux uses the same file structure to provide this service. Each node maintains the last state that the node signed as well as the last state the whole cluster signed. In this way we can assure that the cluster doesn't doublesign. It should look something like the below:
```
{
  "height": "361402",
  "round": 0,
  "step": 3,
  "signature": "IEOS7EJ8C6ZZxwwXiGeMhoO8mwtgTiq6VPR/F1cpLZuz0ZvUZdsgQjTt0GniAIgosfEjC5izKw4Nvvs3ZIceAw==",
  "signbytes": "6B080211BA8305000000000022480A205D4E1F722F53A3FD9E0D28639D7CE7B588338570EBA5C340687C30609C47BCA41224080112208283B6E16BEA46797F8AD4EE0ACE424AC7A4827202446B2D56E7F4438541B7BD2A0C08E4ACE28B0610CCD0AC830232066A756E6F2D31"
}
```
You will need to replace the contents of the `~/.horcrux/state/{chain-id}_priv_validator_state.json` and `~/.horcrux/state/{chain-id}_share_sign_state.json` on each signer node with a truncated and slightly modified version of the file. Note the "" especially on the "round" value:
```
{
  "height": "361402",
  "round": "0",
  "step": 3
}
```
NOTE: This step can be error prone. Strangelove-Ventures will be adding a feature to allow using the CLI to set these values, but for now `nano/vi`, `cat`, and `jq` are your friends.

### Start the horcrux signer cluster
Once you have all of the horcrux signer nodes fully configured its time to start them. Start all of them at roughly the same time:
Choose the approriate configuration:

### ATOM
```
sudo systemctl start horcrux-bcna && journalctl -u horcrux-bcna -f
```
### BCNA
```
sudo systemctl start horcrux-bcna && journalctl -u horcrux-bcna -f
```
### CHIHUAHUA
```
sudo systemctl start horcrux-bcna && journalctl -u horcrux-bcna -f
```
### CMDX
```
sudo systemctl start horcrux-bcna && journalctl -u horcrux-bcna -f
```
### CRBRBUS
```
sudo systemctl start horcrux-bcna && journalctl -u horcrux-bcna -f
```
### DIG
```
sudo systemctl start horcrux-bcna && journalctl -u horcrux-bcna -f
```
### EMONEY
```
sudo systemctl start horcrux-bcna && journalctl -u horcrux-bcna -f
```
### EVMOS
```
sudo systemctl start horcrux-bcna && journalctl -u horcrux-bcna -f
```
### JUNO
```
sudo systemctl start horcrux-bcna && journalctl -u horcrux-bcna -f
```
### NOM
```
sudo systemctl start horcrux-bcna && journalctl -u horcrux-bcna -f
```
### OSMO
```
sudo systemctl start horcrux-bcna && journalctl -u horcrux-bcna -f
```

### Make sure the logs are flowing...
```
I[2021-09-24|02:10:09.022] Tendermint Validator                         module=validator mode=mpc priv_key=...
I[2021-09-24|02:10:09.023] Starting CosignerRPCServer service           module=validator impl=CosignerRPCServer
I[2021-09-24|02:10:09.025] Signer                                       module=validator pubkey=PubKeyEd25519{9A66109B69C...
I[2021-09-24|02:10:09.025] Starting RemoteSigner service                module=validator impl=RemoteSigner
E[2021-09-24|02:10:09.027] Dialing                                      module=validator err="dial tcp 10.180.0.16:1234...
I[2021-09-24|02:10:09.027] Retrying                                     module=validator sleep(s)=3 address=tcp://10.180...
...
```
### Configure and start your full nodes
Once the signer cluster has started successfully its time to reconfigure and restart your sentry nodes. On each node enable the priv validator listener and verify config changes with the following commands:

This command tells your sentry to listen for signatures instead of using local `priv_validator_key.json`, please look at the `~/.profile` on either of the horcrux signers to see the custom port that was configured. 
```
sed -i 's#priv_validator_laddr = ""#priv_validator_laddr = "tcp://0.0.0.0:<custom port>"#g' $NODE_HOME/config/config.toml
cat $NODE_HOME/config/config.toml | grep priv_validator_laddr
priv_validator_laddr = "tcp://0.0.0.0:<custom port>"
```
Ensure any local or network firewalls on the sentry machines are allowing communication from the horcrux cluster to custom `priv_validator_laddr` port. Next, restart your nodes for the changes to take effect, and see them connect to the signer cluster:
```
$ sudo systemctl restart {node_service} && journalctl -u {node_service} -f
```
Common failure modes:
Ports on your cloud service aren't properly configured and prevent signers/sentries from communicating
Node crashes because the signer didn't retry in time, can be fixed by trying again and/or restarting signer. May take some fiddling

## CONGRATS!
You now can sleep much better at night because you are much less likely to have a down validator wake you up in the middle of the night. You have also completed a stressful migration on a production system. Go run around outside screaming, pet your dog, eat a nice meal, hug your kids/significant other, etc... and enjoy the rest of your day!

## Administration Commands
`horcrux elect` - Elect a new cluster leader. Pass an optional argument with the intended leader ID to elect that cosigner as the new leader, e.g. horcrux elect 3 to elect cosigner with ID: 3 as leader

`horcrux cosigner address` - Get the public key address as both hex and optionally the validator consensus bech32 address. To retrieve the valcons bech32 address, pass an optional argument with the chain's bech32 valcons prefix, e.g. horcrux cosigner address cosmosvalcons
