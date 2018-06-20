#!/bin/bash

# =======================================================================================
# Run as root
# =======================================================================================
if [ "$(id -nu)" != "root" ]; then
	sudo -k
	PASSWORD=$(whiptail --backtitle "$PROJECT_NAME Masternode Installer" --title "Authentication required" --passwordbox "Installing $PROJECT_NAME requires root privilege. Please authenticate to begin the installation.\n\n[sudo] Password for user $USER:" 12 50 )
	exec sudo -E -S -p '' "$0" "$@" <<< "$PASSWORD"
	exit 1
fi
# ---------------------------------------------------------------------------------------

# =======================================================================================
# Helper functions
# =======================================================================================
# infobox TEXT
infobox() {
    BASE_LINES=10
    WT_HEIGHT=$(echo -e "$@" | wc -l)
    (( WT_HEIGHT=WT_HEIGHT+BASE_LINES ))
    WT_WIDTH=78
    WT_SIZE="$WT_HEIGHT $WT_WIDTH"
    TERM=ansi whiptail \
    --infobox "$@" \
    --backtitle "$WT_BACKTITLE" \
    --title "$WT_TITLE" \
    $WT_SIZE
}

# msgbox TEXT
msgbox() {
    BASE_LINES=10
    WT_HEIGHT=$(echo -e "$@" | wc -l)
    (( WT_HEIGHT=WT_HEIGHT+BASE_LINES ))
    WT_WIDTH=78
    WT_SIZE="$WT_HEIGHT $WT_WIDTH"
    TERM=ansi whiptail \
    --msgbox "$@" \
    --backtitle "$WT_BACKTITLE" \
    --title "$WT_TITLE" \
    $WT_SIZE
}

# inputbox "TEXT" "DEFAULT"
inputbox() {
    BASE_LINES=10
    WT_HEIGHT=$(echo -e "$@" | wc -l)
    (( WT_HEIGHT=WT_HEIGHT+BASE_LINES ))
    WT_WIDTH=78
    WT_SIZE="$WT_HEIGHT $WT_WIDTH"
    TERM=ansi whiptail \
    --inputbox "$1" \
    --backtitle "$WT_BACKTITLE" \
    --title "$WT_TITLE" \
    3>&1 1>&2 2>&3 \
    $WT_SIZE \
    "$2"
}

# yesnobox TEXT
yesnobox() {
BASE_LINES=8
WT_HEIGHT=$(echo -e "$@" | wc -l)
(( WT_HEIGHT=WT_HEIGHT+BASE_LINES ))
WT_WIDTH=78
WT_SIZE="$WT_HEIGHT $WT_WIDTH"
TERM=ansi whiptail \
--yesno "$@" \
--backtitle "$WT_BACKTITLE" \
--title "$WT_TITLE" \

$WT_SIZE
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
