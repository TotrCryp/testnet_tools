#!/bin/bash

totr_logo_link="https://raw.githubusercontent.com/TotrCryp/assets/main/totr_logo.sh"
wget -q --spider $totr_logo_link
. <(wget -qO- $totr_logo_link)
echo -e "Setup Cascadia rewards checker..."
cd $HOME
wget -q https://raw.githubusercontent.com/TotrCryp/testnet_tools/main/cascadia_rewards_checker.sh && \
read -p "Enter address: " address && \
read -p "Enter validator: " validator && \
read -p "Enter password: " password && \
sed -i 's/^address="".*/address="$address"/; s/^validator="".*/validator="$validator"/; s/^password="".*/password="$password"/' cascadia_rewards_checker.sh && \
chmod +x cascadia_rewards_checker.sh
