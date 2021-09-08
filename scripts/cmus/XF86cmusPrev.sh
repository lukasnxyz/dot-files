#!/bin/sh

if ! pgrep -x cmus ; then 
	$TERMINAL -e cmus
else
	cmus-remote -r
fi
