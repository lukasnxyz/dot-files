#!/bin/sh

echo " $(df -h / | awk '{print $3}' | sed -n '1!p')"
