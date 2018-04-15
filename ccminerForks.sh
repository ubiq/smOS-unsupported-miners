#!/bin/bash

# Run as root
if [[ $(whoami) != "root" ]]; then
    echo "Please run this script as root user"
    exit 1
fi
#
# Helper Functions
#
inputWithDefault() {
    read -r userInput
    userInput=${userInput:-$@}
    echo "$userInput"
}


#
# Set Variables
#

# Location of smOS miners

minerPath='/root/miner_org/'
minerRepo=''

# Which miner to replace?
PS3='Which smOS ccminer would you like to replace?: '
options=("enemy" "MSFTserver-v2.2.5" "nevermore" "skunk-krnlx" "todd1251-x16r" "tpruvot-v2.1" "tpruvot-v2.2.5-x16s" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "nevermore-brian112358-v0.1")
            smosMiner="nevermore-brian112358-v0.1"
            ;;
        "MSFTserver-v2.2.5")
            smosMiner="MSFTserver-v2.2.5"
            ;;
        "skunk-krnlx")
            smosMiner="skunk-krnlx"
            ;;
        "todd1251-x16r-2.2.4.1")
            smosMiner="todd1251-x16r-2.2.4.1"
            ;;
        "tpruvot-v2.1")
            smosMiner="tpruvot-v2.1"
            ;;
        "tpruvot-v2.2.5-x16s-cuda8.0")
            smosMiner="tpruvot-v2.2.5-x16s-cuda8.0"
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done

clear

# What fork of ccminer?
PS3='Please enter the ccminer fork that you would like to replace $smosMiner with: '
options=("allium" "bcd" "dace-cryptonight" "djm34" "klaust" "nanashi" "nevermore" "phi-anxmod" "rvn" "sp-mod" "tpruvot" "xevan" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "allium-2.3.0")
            minerFork="allium-2.3.0"
            ;;
        "bcd-1.0.0 ")
            minerFork="bcd-1.0.0 "
            ;;
        "dace-cryptonight-20180113")
            minerFork="dace-cryptonight-20180113"
            ;;
         "djm34-0.3.0 ")
            minerFork="djm34-0.3.0 "
            ;;
        "klaust-8.21")
            minerFork="klaust-8.21"
            ;;
        "nanashi-2.2.mod.r2")
            minerFork="nanashi-2.2.mod.r2"
            ;;
        "nevermore-0.2.2")
            minerFork="nevermore-0.2.2"
            ;;
        "phi-anxmod-1.0-cuda9")
            minerFork="phi-anxmod-1.0-cuda9"
            ;;
        "rvn-2.3")
            minerFork="rvn-2.3"
            ;;
        "sp-mod-1.5.81")
            minerFork="sp-mod-1.5.81"
            ;;
        "xevan-0.1")
            minerFork="xevan-0.1"
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done
