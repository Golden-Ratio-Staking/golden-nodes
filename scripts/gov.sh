#!bin/bash

$DAEMON_NAME tx gov vote 4 yes \
 --from "$WALLET" \
 --gas "$GAS" \
 --gas-adjustment "1.3" \
 --gas-prices "$GAS_PRICES""$DENOM"
