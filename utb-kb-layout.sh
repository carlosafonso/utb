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

LAYOUT=$1
if [ -z $1 ]; then
	LAYOUT="es"
fi

setxkbmap ${LAYOUT}
