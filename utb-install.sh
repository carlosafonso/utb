#!/bin/bash

#
# utb-install.sh
#
# This scripts installs the UTB suite on
# the user's box. Basically it creates
# symlinks in /usr/local/bin so that all
# UTB scripts are available from anywhere.
#
# Author: Carlos Afonso Pérez
# Date: December 2014
#

. ./inc/utb-inc.sh

if [ "$(whoami)" != "root" ]; then
	utb_pr_error "This scripts needs to be run as the root user."
	exit 1
fi

CNT=0
ERRORS=0
SKIPPED=0
for f in `ls -1`
do
	INSTALL=0
	[[ $f =~ ^utb-.*\.sh$ ]] && INSTALL=1

	if [ $INSTALL -eq 1 ] && [ $f != "utb-install.sh" ]; then
		echo -e "Installing ${BWhite}${UWhite}${f}${Color_Off}..."
		if [ -e /usr/local/bin/$f ]; then
			echo -e "${Yellow}File ${BYellow}${f}${Yellow} is already present${Color_Off}"
			((SKIPPED++))
			continue
		fi

		ln -s `readlink -e $f` /usr/local/bin/$f
		if [ $? -ne 0 ]; then
			echo -e "${IRed}Failed to install $f${Color_Off}"
			((ERRORS++))
		else
			((CNT++))
		fi
	fi
done

if [ $ERRORS -gt 0 ]; then
	utb_pr_error "${ERRORS} scripts were not installed due to errors. Please review the installation output and retry."
elif [ $CNT -eq 0 ] && [ $SKIPPED -eq 0 ]; then
	utb_pr_warning "Looks like no files were installed. Run this script from within the UTB root folder."
else
	utb_pr_success "Successfully installed ${CNT} scripts (skipped ${SKIPPED})."
fi
