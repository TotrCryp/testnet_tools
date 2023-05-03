#!/bin/bash

# Set the PATH variable
PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:/usr/local/go/bin:/root/go/bin

# Set the address and validator information
address=""
validator=""
password=""
min_reward="500000000000000"  # Minimum reward amount to withdraw and restake in udenom
log_file="/var/log/cascadia_rewards_checker.log"

# Get the available rewards
p_rewards=$(cascadiad query distribution rewards $address)
a_rewards=$(echo "$p_rewards" | sed -n '/total:/,/^$/p' | sed -n '2p' | sed 's/- amount: "//;s/"$//')
rewards=$(echo $a_rewards | cut -d'.' -f1)

if [[ $rewards -ge $min_reward ]]; then
        # Withdraw and restake the rewards
        echo "$(date): Withdrawing and restaking rewards..." | tee -a $log_file
        echo "$(date): Withdrawing:" | tee -a $log_file
        cascadiad tx distribution withdraw-rewards $validator --from $address --gas auto --gas-adjustment=1.3 --gas-prices=10aCC --commission -y <<< "$password" >> $log_file
        sleep 5
        p_balance=$(cascadiad q bank balances $address)
        a_balance=$(echo "$p_balance" | sed -n '/balances:/,/^$/p' | sed -n '2p' | sed 's/- amount: "//;s/"$//')
        balance=$(echo $a_balance | cut -d'.' -f1)
        echo "$(date): Available balance: $balance" | tee -a $log_file
        RestakAmount=$(($balance-$min_reward))
        sleep 2
        if [[ $RestakAmount -ge $min_reward ]]; then
                echo "$(date): Restaking:" | tee -a $log_file
                echo "Restake amoumt: $RestakAmount" | tee -a $log_file
                cascadiad tx staking delegate $validator "$RestakAmount"aCC --from $address --gas auto --gas-adjustment=1.3 --gas-prices=10aCC -y <<< "$password" >> $log_file
        fi
else
        # Log that the reward amount is too low
        echo "$(date): Reward amount ($rewards udenom) is below the minimum threshold ($min_reward udenom)." | tee -a $log_file
fi
