#!/bin/bash
##################################################
# Script Name: hashicorp-binary-install.bash     #
# Description: To download and install binary    #
#              from HashiCorp releases           #
# Version: 20230212.01                           #
# Change Logs (Latest on top):                   #
#    20230212.01 - Initial Release               #
##################################################
##################################################

###################
### DEFINITIONS ###
###################
BINARY=$1
ARCH=$2
DIR_TO_INSTALL=/usr/sbin


##############
### CHECKS ###
##############
if [ -z "${BINARY}" ]
then
	echo "USAGE: $0 <terraform | packer | vault> <amd64 | arm64>"
	exit 96
fi
if [ -z "${ARCH}" ]
then
	echo "USAGE: $0 <terraform | packer | vault> <amd64 | arm64>"
	exit 97
fi
if [ -z "${DIR_TO_INSTALL}" ]
then
	echo "[ERROR] DIR_TO_INSTALL is not set."
	exit 98
fi
if [ ! -d "${DIR_TO_INSTALL}" ]
then
	echo "[ERROR] Directory ${DIR_TO_INSTALL} does not exists." 
	exit 99
fi


############
### MAIN ###
############
LATEST_VERSION=`curl -s https://releases.hashicorp.com/index.json 2>/dev/null | jq -r '."'"${BINARY}"'".versions[].version' | egrep -v 'alpha|beta|rc|ent' | sort -t. -k 1,1nr -k 2,2nr -k 3,3nr | head -1`
BINARY_URL=`curl -sL https://releases.hashicorp.com/${BINARY}/index.json | jq -r '.versions[].builds // [] | .[].url' | egrep -v 'alpha|beta|rc|ent' | grep ${LATEST_VERSION} | egrep 'linux.*'${ARCH}''`
echo "[INFO] Downloading ${BINARY_URL}..."
curl -so /tmp/${BINARY}.zip ${BINARY_URL}

if [ $? -eq 0 ]
then
	unzip -qo -d ${DIR_TO_INSTALL} /tmp/${BINARY}.zip
	chmod 755 ${DIR_TO_INSTALL}/${BINARY}
	${DIR_TO_INSTALL}/${BINARY} --version
	rm -f /tmp/${BINARY}.zip
else
	echo "[ERROR] Download failed!"
	exit 100
fi
