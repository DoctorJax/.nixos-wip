#!/usr/bin/env bash

minimize() {
    winID="$(xdotool getactivewindow)"
    xdotool windowunmap "$winID"
    echo "$winID" >> "$HOME"/.cache/miniwinID
}

maximize() {
    xdotool windowmap "$(tail -n1 "$HOME"/.cache/miniwinID)"
    sed -i '$d' "$HOME"/.cache/miniwinID
}

quickempty() {
    focusmon=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .id')

    NB_MONITORS=($(hyprctl monitors -j | jq -r '.[] | .id'))
    for id in "${NB_MONITORS[@]}"; do
        hyprctl dispatch focusmonitor "$id"
        focusedname=$(hyprctl monitors -j | jq -r ".[] | select(.focused) .name")
        haswindows=$(hyprctl workspaces -j | jq -r ".[] | select((.monitor == \"$focusedname\") and .windows) .id" | sort | tail -1)

        if [[ $(hyprctl workspaces -j | jq -r ".[] | select(.id == $haswindows) .windows") != "0" ]]; then
            plusone=$((haswindows + 1))
            hyprctl dispatch workspace "$plusone"
        fi

        ydotoold &
        sleep 0.1
        ydotool mousemove -- 1 0
        kill $!

        if [[ "$(hyprctl activewindow -j | jq -r '.workspace.name' | awk -F ':' '{ print $1 }')" == "special" ]]; then
            specialworkspace=$(hyprctl activewindow -j | jq -r '.workspace.name' | awk -F ':' '{ print $2 }')
            hyprctl dispatch togglespecialworkspace "$specialworkspace"
        fi
    done

    hyprctl dispatch focusmonitor "$focusmon"

    killall swaybg
}

case "$1" in
    -n) minimize ;;
    -m) maximize ;;
    -q) quickempty ;;
esac
