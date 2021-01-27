#!/bin/sh

echo "(cpu)$(sensors | awk '/^Package id/ { print $4 }')"

#sensors | awk '/^Package id/ { print $4 }' | sed -e 's/+//' -e 's/C//' -e 's/°//' -e 's/.$//' -e 's/.$//' >> ~/tempsLog.txt
