#!/usr/bin/env bash

random() {
    randomwall="$(find ~/Wallpapers -name '*.[jp][pn]g' -type f | shuf -n 1)"
    feh --bg-fill -z "$randomwall"
    pkill swaybg
    swaybg --image "$randomwall" -m fill &
    printf "Random background has been chosen."
}

randomLandscape() {
    randomwall="$(find ~/Wallpapers/landscape -name '*.[jp][pn]g' -type f | shuf -n 1)"
    feh --bg-fill -z "$randomwall"
    pkill swaybg
    swaybg --image "$randomwall" -m fill &
    printf "Random background has been chosen."
}

randomAnime() {
    randomwall="$(find ~/Wallpapers/anime -name '*.[jp][pn]g' -type f | shuf -n 1)"
    feh --bg-fill -z "$randomwall"
    pkill swaybg
    swaybg --image "$randomwall" -m fill &
    printf "Random background has been chosen."
}

restore() {
    restorewall=$(awk '{ print $4 }' "$HOME"/.fehbg | sed "s/'//g")
    "$HOME"/.fehbg
    pkill swaybg
    swaybg --image $restorewall -m fill &
    printf "Background has been restored."
}

setwall=$2
setbg() {
    feh --bg-fill -z "$setwall"
    pkill swaybg
    swaybg --image "$setwall" -m fill & 
    printf "Background has been set to $setwall."
}

help() {
    printf "\n Type -i for restore, -s to set new, or -r for random \n"
}

case "$1" in
    -i) restore ;;
    -r ) random ;;
    -rl) randomLandscape ;;
    -ra) randomAnime ;;
    -s) setbg ;;
    -h) help ;;
esac
