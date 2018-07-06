#!/bin/bash
# Author: Greerso https://github.com/greerso
# Steemit:  https://steemit.com/@greerso
#
# BTC 1BzrkEMSF4aXBtZ19DhVf8KMPVkXjXaAPG
# ETH 0x0f64257fAA9E5E36428E5BbB44C9A2aE3A055577
# LTC LRf2oaNjLH18UtfXnr6GG34c3xv6To2XeZ
# ZEC t1QCnCQstdgvZ5v3P9sZbeT9ViJd2pDfNBL
# ZEN zndLiWRo7cYeAKuPArtpQ6HNPi6ZdaTmLFL
# ZEL t1RdEHDboaRwpoBVQDuQ9bEpBmFqU1dFBR6

# =======================================================================================
# Set Variables
# =======================================================================================
# Location of smOS miners
export NEWT_COLORS=''
minerRoot="/root/miner_org/"
smosMiners=($(ls $minerRoot))
URL="https://api.github.com/repos/greerso/smOS-unsupported-miners/contents/miners"
declare -A githubJSON="($(
  curl -fsSL "${URL}" \
  | jq '.[]  | "[" + .name + "]=\"" +.download_url + "\""' -r 
))"
IFS=$'\n' read -r -d '' -a githubMiners < <(set -o pipefail; curl --fail -kfsSL "https://api.github.com/repos/greerso/smOS-unsupported-miners/contents/miners" | jq -r '.[].name' && printf '\0')
# ---------------------------------------------------------------------------------------

# =======================================================================================
# Helper functions
# =======================================================================================
# Ask user for input, offer a default value example use:
# echo "Please enter a value: (Default: new_value)"
# newValue=$(inputWithDefault new_value)
inputWithDefault() {
    read -r userInput
    userInput=${userInput:-$@}
    echo "$userInput"
}

IAmRoot() {
	    if [ "$(id -nu)" != "root" ]; then
    sudo -k
    PASSWORD=$(whiptail --backtitle "I AM ROOT!" --title "Authentication required" --passwordbox "This script requires root privilege. Please authenticate to begin.\n\n[sudo] Password for user $USER:" 12 50 3>&2 2>&1 1>&3-)
    exec sudo -E -S -p '' "$0" "$@" <<< "$PASSWORD"
    exit 1
    fi
}

#findBin [path]
smosMinerBin() {
	smosMinerBin="$(find $1 -maxdepth 1 -type f -executable -printf "%f\n" -quit)"
}

# ---------------------------------------------------------------------------------------


# =======================================================================================
# Run as root
# =======================================================================================
IAmRoot
# ---------------------------------------------------------------------------------------

# =======================================================================================
# Which smOS miner to replace?
# =======================================================================================
printf "Please select the miner to replace:\n"
select smosMiner in ${smosMiners[@]}; do test -n "$smosMiner" && break; echo ">>> Invalid Selection"; done
smosMinerBin $minerRoot$smosMiner/
clear
# ---------------------------------------------------------------------------------------

# =======================================================================================
# Which miner to replace $smosMiner with?
# =======================================================================================
printf "Please select the miner to replace $smosMiner with:\n"
select minerFork in ${githubMiners[@]%.gz}; do test -n "$minerFork" && break; echo ">>> Invalid Selection"; done
clear
echo "You're replacing $smosMiner with $minerFork"
# ---------------------------------------------------------------------------------------

# =======================================================================================
# Download miner
# =======================================================================================
minerForkURL=${githubJSON[$minerFork.gz]}
# ---------------------------------------------------------------------------------------

# =======================================================================================
# Switch out miner and create masquerade symlink
# =======================================================================================
mv $minerRoot$smosMiner/$smosMinerBin $minerRoot$smosMiner/$smosMiner.backup
curl -fsSL $minerForkURL | gunzip > $minerRoot$smosMiner/$minerFork
chmod +x $minerRoot$smosMiner/$minerFork
chown miner:miner $minerRoot$smosMiner/$minerFork
ln -s $minerRoot$smosMiner/$minerFork $minerRoot$smosMiner/$smosMinerBin
clear
# ---------------------------------------------------------------------------------------

# =======================================================================================
# Done.
# =======================================================================================
echo "###"
echo "$smosMiner is now $minerFork!"
echo "###"
echo ""
# $minerRoot$smosMiner/$smosMinerBin --version
echo ""
echo "###"
echo "You should now configure your Rig Group for $smosMiner remembering that it is $minerFork"
echo "###"
# ---------------------------------------------------------------------------------------
