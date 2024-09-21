#! /bin/bash

case $1/$2 in
    move/*)
        if [[ "$(hyprctl -j monitors | jaq -r '.[] | .id' | wc -l)" = "1" ]]; then
            hyprctl dispatch movetoworkspacesilent "$2"
        else
            monitornum=$(hyprctl monitors -j | jaq -r '.[] | select(.focused == true) | .id')
            hyprctl dispatch movetoworkspacesilent "$monitornum$2"
        fi
        ;;
    workspace/*)
        if [[ "$(hyprctl -j monitors | jaq -r '.[] | .id' | wc -l)" = "1" ]]; then
            hyprctl dispatch workspace "$2"
        else
            monitornum=$(hyprctl monitors -j | jaq -r '.[] | select(.focused == true) | .id')
            hyprctl dispatch workspace "$monitornum$2"
        fi
        ;;
    */*)
        echo -ne "hi"
        ;;
esac
