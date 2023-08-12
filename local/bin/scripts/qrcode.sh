#!/bin/sh

clipboardContent=$(xclip -selection c -o)
qrencode -s 20 -o /tmp/qrcode.png $clipboardContent
sxiv /tmp/qrcode.png
