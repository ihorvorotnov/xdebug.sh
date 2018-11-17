#!/bin/bash
#
# Xdebug Toggle
#
# Toggles xdebug php extension on and off. 
# Requires macOS, Homebrew and Laravel Valet.
# 
# Project URL:  https://github.com/ihorvorotnov/xdebug
# Author:       Ihor Vorotnov <ihor.vorotnov@gmail.com>
# Author URL:   https://ihorvorotnov.com
# Version:      1.0
# License:      MIT
#

# Define variables

CONFIG_PATH="/usr/local/etc/php/7.2/conf.d/"
CONFIG_NAME="ext-xdebug.ini"
CONFIG_NAME_DISABLED="ext-xdebug.ini"

# Define colors

black=$(tput setaf 0)
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
magenta=$(tput setaf 5)
cyan=$(tput setaf 6)
white=$(tput setaf 7)
gray=$(tput setaf 8)
off=$(tput sgr0)

# Functions

function error_message() {
		echo -e "\n⚠️  ${red}$1${off}"
}

function success_message() {
		echo -e "\n🐘 ${yellow}$1${off}\n"
}

function help_message() {
		echo -e "\nUsage:"
		echo -e "\n${green}> xdebug${off} ${yellow}[arg]${off}\n"
		echo -e "Available args:\n"
		echo -e "${yellow}on${off}       – Toggles Xdebug on"
		echo -e "${yellow}off${off}      – Toggles Xdebug off"
		echo -e "${yellow}status${off}   - Shows Xdebug status"
		echo -e "${yellow}help${off}     - Displays this help"
}

# Handle passed args
case "$1" in
	"")
		error_message "Missing argument."
		help_message
		exit 1
		;;
	"on")
		success_message "Enabling Xdebug..."
		;;
	"off")
		success_message "Disabling Xdebug..."
		;;
	"help")
		help_message
		exit 0
		;;
	"status")
		success_message "Checking Xdebug status..."
		exit 0
		;;
	*)
		error_message "Invalid argument."
		help_message
		exit 1
		;;
esac