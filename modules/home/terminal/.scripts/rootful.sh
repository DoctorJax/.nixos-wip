#!/usr/bin/env bash

Xwayland -noreset -fullscreen -geometry 2560x1080 :10 &

sleep 1

hyprctl dispatch submap passthrough

DISPLAY=:10 bspwm -c ~/.config/bspwm/rootful/bspwmrc

pkill Xwayland

hyprctl dispatch submap reset
