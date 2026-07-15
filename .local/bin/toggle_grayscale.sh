#!/bin/bash
if pgrep picom; then
  pkill picom
else
  picom --backend glx --window-shader-fg ~/.config/picom/grayscale.glsl --no-vsync -D 0 --no-fading-openclose &
fi
