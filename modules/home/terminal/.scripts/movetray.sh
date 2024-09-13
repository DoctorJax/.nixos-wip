#!/usr/bin/env bash

killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

left() {
    if type "xrandr"; then
        for m in $(xrandr --query | grep " connected" | cut -d" " -f1 | tac); do
            if [ $m == 'DP-1' ]
            then
                MONITOR=$m polybar --reload jackson & disown
                sleep 0.1
            elif [ $m == 'HDMI-0' ]
            then
                MONITOR=$m polybar --reload jackson & disown
            fi
        done
    fi

}
left
