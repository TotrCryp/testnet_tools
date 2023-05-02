#!/bin/bash

totr_logo_link="https://raw.githubusercontent.com/TotrCryp/assets/main/totr_logo.sh"

wget -q --spider $totr_logo_link
. <(wget -qO- $totr_logo_link)
echo -e "Setup Cascadia rewards checker..."
cd
wget https://raw.githubusercontent.com/TotrCryp/testnet_tools/main/cascadia_rewards_checker.sh && \
read -p "Enter value 1: " address && \
read -p "Enter value 2: " validator && \
read -p "Enter value 2: " password && \
echo "address=$address" >> cascadia_rewards_checker.sh && \
echo "validator=$validator" >> cascadia_rewards_checker.sh && \
echo "password=$password" >> cascadia_rewards_checker.sh && \
chmod +x cascadia_rewards_checker.sh
