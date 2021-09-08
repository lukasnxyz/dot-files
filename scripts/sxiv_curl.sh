#!/bin/sh

curl --output "img_download.jpg" "$1"
sxiv img_download.jpg
rm -f img_download.jpg
