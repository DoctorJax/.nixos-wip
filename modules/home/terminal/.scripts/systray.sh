#!/usr/bin/env bash

EWW="eww"

starttray() {
    killtray
    waybar
}

killtray() {
    killall waybar
}

toggle() {
    if [[ ! $(pidof waybar) ]]; then
        starttray
    else
        killtray
    fi
}

bars() {
    ags -t bar-$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .id')
}

case "$1" in
    -s ) starttray ;;
    -k ) killtray ;;
    -t ) toggle ;;
    -b ) bars ;;
esac
