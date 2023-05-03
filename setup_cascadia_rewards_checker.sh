#!/bin/bash

totr_logo_link="https://raw.githubusercontent.com/TotrCryp/assets/main/totr_logo.sh"
#wget -q --spider $totr_logo_link
. <(wget -qO- $totr_logo_link)
echo -e "Setup Cascadia rewards checker..."
echo -e "The script checks for claimable  rewards every 15 minutes."
echo -e "If the amount of rewards exceeds 500000000000000 aCC, rewards are received (including commissions)."
echo -e "Then the available balance of the address is checked and the available amount for the restake is determined"
echo -e "(as available_balance - 500000000000000 so as not to empty the wallet),"
echo -e "and delegation to the validator takes."
echo -e "Logs are stored in /var/log/cascadia_rewards_checker.log"

read -r -p "Continue? [y/n]" response
    case "$response" in
        [yY][eE][sS]|[yY])
            cd $HOME
            wget -q https://raw.githubusercontent.com/TotrCryp/testnet_tools/main/cascadia_rewards_checker.sh && \
            read -p "Enter address (looks like cascadia123...): " address && \
            read -p "Enter validator (looks like cascadiavaloper123...): " validator && \
            read -p "Enter keyring passphrase (should look like something incomprehensible): " password && \
            sed -i "s/^address=\"\".*/address=\"$address\"/; s/^validator=\"\".*/validator=\"$validator\"/; s/^password=\"\".*/password=\"$password\"/" cascadia_rewards_checker.sh && \
            chmod +x cascadia_rewards_checker.sh  && \
            crontab -l | { cat; echo "*/15 * * * * $HOME/cascadia_rewards_checker.sh"; } | crontab -  && \
            echo -e "Done!"
            ;;
        *)
            echo \-e "Canceled"
            ;;
    esac
