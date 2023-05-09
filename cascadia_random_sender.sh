#!/bin/bash

# Set the PATH variable
PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:/usr/local/go/bin:/root/go/bin

# Use sleep with a random duration to reduce the effect of synchronicity
sleeping_time=$(( $RANDOM % 300 ))
echo "Sleeping $sleeping_time ..."
sleep $sleeping_time

# Set the address and validator information
address=""
password=""
send_amount="10000000"

# Get the number of validators.
# Generate a random number in the range from 1 to the number of validators.
# Get a random valoper.
range=$(cascadiad q staking validators --limit=1000 --output json | jq -r '.validators[].operator_address' | wc -l)
number=$(( $RANDOM % $range + 1 ))
valoper=$(cascadiad q staking validators --limit=1000 --output json | jq -r '.validators[].operator_address' | sed -n ''$number'p')
echo "Random valoper is: $valoper"
# Get gelegator address as recipient address.
recipient_address=$(cascadiad query staking delegations-to $valoper --limit=1  -o json | jq -r '.delegation_responses[0].delegation.delegator_address')
echo "Random address is: $recipient_address"
# Sending...
cascadiad tx bank send $address $recipient_address ''$send_amount'aCC' --note "Cascadia randomly sending" --gas auto --gas-adjustment=1.5 --gas-prices=10aCC -y <<< "$password"
