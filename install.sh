#!/bin/sh

cd ./wallets
./generateAll.sh
cd ..

docker compose build
