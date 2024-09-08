#!/bin/sh

AO_WALLET_ADDRESS=$(./wallets/printWalletAddresses.mjs | awk -F" " '/ao-wallet.json/ {print $1}')
BUNDLER_WALLET_ADDRESS=$(./wallets/printWalletAddresses.mjs | awk -F" " '/bundler-wallet.json/ {print $1}')
SCHEDULER_WALLET_ADDRESS=$(./wallets/printWalletAddresses.mjs | awk -F" " '/scheduler-location-publisher-wallet.json/ {print $1}')
USER_WALLET_ADDRESS=$(./wallets/printWalletAddresses.mjs | awk -F" " '/user-wallet.json/ {print $1}')

./seed/reset.mjs 

echo AO wallet balance \($AO_WALLET_ADDRESS\): 
curl -q http://localhost:4000/mint/$AO_WALLET_ADDRESS/1000000000000000
echo
echo bundler wallet balance \($BUNDLER_WALLET_ADDRESS\): 
curl -q http://localhost:4000/mint/$BUNDLER_WALLET_ADDRESS/1000000000000000
echo
echo scheduler wallet balance \($SCHEDULER_WALLET_ADDRESS\): 
curl -q http://localhost:4000/mint/$SCHEDULER_WALLET_ADDRESS/1000000000000000
echo
echo user wallet balance \($USER_WALLET_ADDRESS\): 
curl -q http://localhost:4000/mint/$USER_WALLET_ADDRESS/1000000000000000
echo

./seed/publish-scheduler-location.mjs
./seed/mine.mjs