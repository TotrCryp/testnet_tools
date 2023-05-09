# Testnet tools
Tools used when participating in testnets

# Cascadia rewards checker
**cascadia_rewards_checker.sh**
This script checks for claimable rewards.
If the amount of rewards exceeds 500000000000000 aCC, rewards are received (including commissions).
Then the available balance of the address is checked and the available amount for the restake is determined (as available_balance - 500000000000000 so as not to empty the wallet), and delegation to the validator takes.

**setup_cascadia_rewards_checker.sh**
The script ensures that the automatic setup command is executed and configures execution every 15 minutes using Cron.

**Setup command:**
```Shell
. <(wget -qO- https://raw.githubusercontent.com/TotrCryp/testnet_tools/main/setup_cascadia_rewards_checker.sh)
```

# Cascadia random sender
**cascadia_random_sender.sh**
The script is intended for use in the devnet/testnet of the Cascadia project (it can also be adapted for use in other projects in the Cosmos ecosystem).
Purpose: to organize the periodic creation of assets transfer transactions on an ongoing basis.
This, in turn, should increase the load on the devnet/testnet and bring it closer to the operating conditions of the mainnet.
For this purpose, the script is launched with a certain frequency (it is assumed that every 20 minutes). At each launch, a random validator is chosen, it can be either from the active set or from the inactive set. Then the address from which the first delegation was made is obtained (it is expected to be the account address).
10000000 aCC are sent to the received address.
Thus, each user of the script creates about 72 transactions per day.
The amount that the user will spend per day is many times smaller than the daily request from the faucet.
In addition, if many users join the use of the script, the costs will be partially offset (or possibly completely).
Given that the time on users' servers can be quite precisely synchronized, and also that Cron is used to periodically run the script, this can lead to abnormal peak loads on the network (that is, several users will send transactions simultaneously), which is not inherent for the mainnet.
To reduce this effect, the sending is not done immediately after the script is started. Before sending, there is a waiting period, the duration of which is determined randomly (from 0 to 300 seconds).

**setup_cascadia_random_sender.sh**
The script ensures that the automatic setup command is executed and configures execution every 20 minutes using Cron.

**Setup command:**
```Shell
. <(wget -qO- https://raw.githubusercontent.com/TotrCryp/testnet_tools/main/setup_cascadia_random_sender.sh)
```
