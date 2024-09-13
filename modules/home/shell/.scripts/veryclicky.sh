#!/usr/bin/env bash

delay="750"

if [[ -n "$2" ]]
then
    delay="$2"
fi

startydotool() {
    ydotoold &
    notify-send -t 2000 -a System "Macro" "Ydotool Started"
}

killydotool() {
    pkill -9 ydotoold
    pkill -9 ydotool
    notify-send -t 2000 -a System "Macro" "Killed Ydotool"
}

mobgrinder() {
    notify-send -t 2000 -a System "Macro" "Mob Grinder: Activated With $delay Delay"
    ydotool click --repeat 1000000 --next-delay $delay 0xC0
    notify-send -t 2000 -a System "Macro" "Mob Grinder: Deactivated"
}

rightclick() {
    case "$3" in
        spam)
            notify-send -t 2000 -a System "Macro" "Rightclick: Spam"
            ydotool click --repeat 1000000 --next-delay $delay 0xC1
            notify-send -t 2000 -a System "Macro" "Rightclick: Deactivated"
        ;;
        hold)
            notify-send -t 2000 -a System "Macro" "Rightclick: Hold"
            ydotool click 0x41
        ;;
    esac
}

leftclick() {
    notify-send -t 2000 -a System "Macro" "Leftclick: Hold"
    ydotool click 0x40
}

case "$1" in
    -s) startydotool ;;
    -k) killydotool ;;
    -m) mobgrinder ;;
    -l) leftclick ;;
    -r) rightclick "$@" ;;
esac
