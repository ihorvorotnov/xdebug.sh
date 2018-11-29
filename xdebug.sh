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
# @todo Add config path auto discovery
#

# ---
# Define variables
# ---

# Config data
CONFIG_PATH="/usr/local/etc/php/7.2/conf.d/"
CONFIG_NAME="ext-xdebug.ini"
CONFIG_NAME_DISABLED="$CONFIG_NAME.disabled"

# Colors
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

# ---
# Define functions
# ---

# Print formatted error message
function error_message() {
	echo -e "\n⚠️  ${red}$1${off}"
}

# Print formatted success message
function success_message() {
	echo -e "\n🐘 $1"
}

# Print formatted help/info message
function help_message() {
	echo -e "\n   Usage:"
	echo -e "     ${green}> xdebug${off} ${yellow}[arg]${off}\n"
	echo -e "   Available args:"
	echo -e "     ${yellow}on${off}       – Toggles Xdebug on"
	echo -e "     ${yellow}off${off}      – Toggles Xdebug off"
	echo -e "     ${yellow}status${off}   - Shows Xdebug status"
	echo -e "     ${yellow}help${off}     - Displays this help"
}

# Check if Xdebug is enabled
function check_status() {
	STATUS=$( php -m | grep xdebug )
	return
}

# Print message corresponding to Xdebug status
function status_message() {
	check_status
	if [[ $STATUS == "" ]]; then
		success_message "Xdebug extension is currently ${red}disabled${off}.\n   Run '${white}xdebug on${off}' to enable it."
	else
		success_message "Xdebug extension is currently ${green}enabled${off}.\n   Run '${white}xdebug off${off}' to disable it."
	fi
}

# Check if Xdebug is installed
function check_installed() {
	INSTALLED=$( pecl list | grep xdebug )
	if [[ ${INSTALLED} == "" ]]; then
		error_message "It looks like Xdebug extension is not installed yet.\n   Please install it via PECL first."
		exit 1;
	fi
}

# Enable Xdebug config file
function enable_xdebug() {
	mv "$CONFIG_PATH$CONFIG_NAME_DISABLED" "$CONFIG_PATH$CONFIG_NAME"
}

# Disable Xdebug config file
function disable_xdebug() {
	mv "$CONFIG_PATH$CONFIG_NAME" "$CONFIG_PATH$CONFIG_NAME_DISABLED"
}

# ---
# Run the app
# ---

# Check if Xdebug extension is installed
check_installed

# Handle passed args
case "$1" in
	"")
		error_message "Missing argument."
		help_message
		exit 1
		;;
	"on")
		check_status
		if [[ $STATUS != "" ]]; then
			success_message "Xdebug extension is already ${green}enabled${off}."
			exit 1
		fi
		success_message "Enabling Xdebug...\n"
		enable_xdebug
		valet restart
		status_message
		;;
	"off")
		check_status
		if [[ $STATUS == "" ]]; then
			success_message "Xdebug extension is already ${red}disabled${off}."
			exit 1
		fi
		success_message "Disabling Xdebug...\n"
		disable_xdebug
		valet restart
		status_message
		;;
	"help")
		help_message
		exit 0
		;;
	"status")
		status_message
		exit 0
		;;
	*)
		error_message "Invalid argument '$1'."
		help_message
		exit 1
		;;
esac
