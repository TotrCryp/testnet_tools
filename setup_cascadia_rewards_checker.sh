#!/bin/bash

totr_logo_link="https://raw.githubusercontent.com/TotrCryp/assets/main/totr_logo.sh"
wget -q --spider $totr_logo_link
. <(wget -qO- $totr_logo_link)
echo -e "Setup Cascadia rewards checker..."
cd
wget -q --spider https://raw.githubusercontent.com/TotrCryp/testnet_tools/main/cascadia_rewards_checker.sh && \
read -p "Enter address: " address && \
read -p "Enter validator: " validator && \
read -p "Enter password: " password && \
echo "address=$address" >> cascadia_rewards_checker.sh && \
echo "validator=$validator" >> cascadia_rewards_checker.sh && \
echo "password=$password" >> cascadia_rewards_checker.sh && \
chmod +x cascadia_rewards_checker.sh
