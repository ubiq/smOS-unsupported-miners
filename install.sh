#!/bin/bash

# =======================================================================================
# Run as root
# =======================================================================================
if [[ $(whoami) != "root" ]]; then
    echo "Please run this script as root user"
    exit 1
fi
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
# ---------------------------------------------------------------------------------------

# =======================================================================================
# Set Variables
# =======================================================================================
# Location of smOS miners
minerRoot="/root/miner_org/"
smosMiners=($(ls $minerRoot))
URL="https://api.github.com/repos/greerso/smOS-unsupported-miners/contents/miners"
declare -A githubJSON="($(
  curl -fsSL "${URL}" \
  | jq '.[]  | "[" + .name + "]=\"" +.download_url + "\""' -r 
))"
IFS=$'\n' read -r -d '' -a githubMiners < <(set -o pipefail; curl --fail -kfsSL "https://api.github.com/repos/greerso/smOS-unsupported-miners/contents/miners" | jq -r '.[].name' && printf '\0')

clear
# ---------------------------------------------------------------------------------------

# =======================================================================================
# Which smOS miner to replace?
# =======================================================================================
printf "Please select the miner to replace:\n"
select smosMiner in ${smosMiners[@]}; do test -n "$smosMiner" && break; echo ">>> Invalid Selection"; done
smosMinerBin="$(find $minerRoot$smosMiner/ -maxdepth 1 -type f -size +512k -executable -printf "%f\n" -quit)"
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
# Install OhGodAnETHlargementPill
# =======================================================================================
read -p "Would you like to install and run OhGodAnETHlargementPill? " choice
case "$choice" in 
  y|Y ) curl -L -o /root/utils/OhGodAnETHlargementPill https://github.com/OhGodACompany/OhGodAnETHlargementPill/raw/master/OhGodAnETHlargementPill-r2
  echo "To run OhGodAnETHlargementPill run 'screen -dmS OhGodAnETHlargementPill sudo /root/utils/OhGodAnETHlargementPill --revA 0,3,4' where 0,3,4 are cards with RAM that is not DDR5"
  ;;
	* ) echo "skipped";;
esac
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
