#!/bin/bash

# Run as root
if [[ $(whoami) != "root" ]]; then
    echo "Please run this script as root user"
    exit 1
fi
#
# Helper Functions
#

# Ask user for input, offer a default value example use:
# echo "Please enter a value: (Default: new_value)"
# newValue=$(inputWithDefault new_value)
inputWithDefault() {
    read -r userInput
    userInput=${userInput:-$@}
    echo "$userInput"
}

#
# Set Variables
#

# Location of smOS miners
minerRoot="/root/miner_org/"
smosMiners="$(find $minerRoot -name 'ccminer' -printf '%h\n' | sed 's!.*/!!' | sort -u)"
# minerRepo='https://github.com/greerso/scrypts/raw/master/miners/'
githubMiners="$(curl -s https://api.github.com/repos/greerso/scrypts/contents/miners | jq '.[].name')"
githubURLs="$(curl -s https://api.github.com/repos/greerso/scrypts/contents/miners | jq '.[].download_url')"

clear

# Which smOS miner to replace?
printf "Please select the miner to replace:\n"
select smosMiner in $smosMiners; do test -n "$smosMiner" && break; echo ">>> Invalid Selection"; done

echo "You selected $smosMiner"

clear

# Which miner to replace $smosMiner with?
printf "Please select the miner to replace $smosMiner with:\n"
select minerFork in $githubMiners; do test -n "$minerFork" && break; echo ">>> Invalid Selection"; done
clear
echo "You're replacing $smosMiner with $minerFork"

#
# Download miner
#

minerForkURL="$(curl -s https://api.github.com/repos/greerso/scrypts/contents/miners | jq '.[] | select(.name=="$minerFork") | .download_url')"

mv $minerRoot$smosMiner/ccminer $minerRoot$smosMiner/ccminer.$smosMiner
curl -fsSL $minerForkURL | gunzip > $minerRoot$smosMiner/ccminer.$minerFork
chmod +x $minerRoot$smosMiner/ccminer.$minerFork
ln -s $minerRoot$smosMiner/ccminer.$minerFork $minerRoot$smosMiner/ccminer

clear

echo "$smosMiner is now $minerFork!"
$minerRoot$smosMiner/ccminer -v
echo "You should now configure your Rig Group for $smosMiner remembering that it is $minerFork"