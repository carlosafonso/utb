#!/bin/bash

#
# utb-kb-layout.sh
#
# Script for switching the keyboard layout
# to the one spcified.
#
# As a startup script it's useful when
# Ubuntu incorrectly changes the chosen layout
# upon boot.
#
# Author: Carlos Afonso <carlos.afonso.perez@gmail.com>
# Date: December 2014
#

. ./inc/utb-inc.sh

LAYOUT=$1
if [ -z $1 ]; then
	LAYOUT="es"
fi

setxkbmap ${LAYOUT}

if [ $? -eq 0 ]; then
	utb_pr_success "Keyboard layout switched successfully."
else
	utb_pr_error "Failed to switch keyboard layout."
fi
