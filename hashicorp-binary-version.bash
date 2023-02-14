#!/bin/bash
##################################################
# Script Name: hashicorp-binary-version.bash     #
# Description: To get the latest binary version  #
#              from HashiCorp releases           #
# Version: 20230214.01                           #
# Change Logs (Latest on top):                   #
#    20230214.01 - Initial Release               #
##################################################
##################################################

###################
### DEFINITIONS ###
###################
BINARY=$1
ARCH=$2


##############
### CHECKS ###
##############
if [ -z "${BINARY}" ]
then
	echo "USAGE: $0 <terraform | packer | vault> <amd64 | arm64>"
	exit 98
fi
if [ -z "${ARCH}" ]
then
	echo "USAGE: $0 <terraform | packer | vault> <amd64 | arm64>"
	exit 99
fi


############
### MAIN ###
############
LATEST_VERSION=`curl -s https://releases.hashicorp.com/index.json 2>/dev/null | jq -r '."'"${BINARY}"'".versions[].version' | egrep -v 'alpha|beta|rc|ent' | sort -t. -k 1,1nr -k 2,2nr -k 3,3nr | head -1`
if [ $? -eq 0 ]
then
	echo ${LATEST_VERSION}
else
	echo "[ERROR] Unable to get version!"
	exit 100
fi