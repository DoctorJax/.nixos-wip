#!/usr/bin/env bash

copyscreenshot(){
    case "$XDG_SESSION_TYPE" in
        x11) maim -u -s -n -m 1 | xclip -selection clipboard -t image/png && notify-send -t 2000 -a System "Screenshot.sh" "Copied to clipboard";;
        wayland) grimblast --notify copy area ;;
        *) echo "Uh, nothing found? Goodluck"; exit 0 ;;
    esac
}

timestamp(){
    pickLocation=$(cat /tmp/.screenshot.sh.tmp)

    if [[ -n "$2" ]]
    then
        pickLocation="$2"
        echo "$pickLocation" > /tmp/.screenshot.sh.tmp
        exit
    fi

    if [[ -z "$pickLocation" ]]
    then
        pickLocation=$(zenity --file-selection --directory)
        echo "$pickLocation" > /tmp/.screenshot.sh.tmp
        exit
    fi

    case "$XDG_SESSION_TYPE" in
        x11) maim -u -s "$pickLocation"/"$(date +%m-%d-%Y_%T).png" && notify-send -t 2000 -a System "Screenshot.sh" "Saved to: $pickLocation" ;;
        wayland) grimblast save area - > "$pickLocation"/"$(date +%m-%d-%Y_%T).png" && notify-send -t 2000 -a System "Screenshot.sh" "Saved to: $pickLocation" ;;
        *) echo "Uh, nothing found? Goodluck"; exit 0 ;;
    esac
}

case "$1" in
    -t) timestamp "$@";;
    *) copyscreenshot ;;
esac
