#!bin/bash

"$DAEMON_NAME" tx staking edit-validator \
  --chain-id="$CHAIN_ID" \
  --commission-rate="0.05" \
  --details="Bare Metal Interchain Relayer and Validator. Powered by the most beautiful number in the Cosmos!" \
  --from="$WALLET" \
  --gas="$GAS" \
  --gas-adjustment= "1.3" \
  --gas-prices="$GAS_PRICES""$DENOM" \
  --security-contact="info@goldenstaking.com" \
  --website="https://www.goldenstaking.com"
