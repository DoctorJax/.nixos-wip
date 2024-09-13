#!/usr/bin/env bash

up() {
    mpc volume +5
    notify-send -t 2000 -a System "MPD" "$(mpc | tail -n1 | awk -F ' ' '{ print $2 }')"
}

down() {
    mpc volume -5
    notify-send -t 2000 -a System "MPD" "$(mpc | tail -n1 | awk -F ' ' '{ print $2 }')"
}

player() {
    kitty -e ncmpcpp
}

loadstreambeats() {
    mpc clear
    mpc load streambeats
    mpc shuffle
    mpc play
    notify-send -t 2000 -a System "MPD" "Playlist: StreamBeats"
}

randomplaylist() {
    cd ~/Music
    mpc clear
    mpc update
    mpc add $(\ls)
    mpc shuffle
    mpc play
    cd ~
    notify-send -t 2000 -a System "MPD" "Playlist: Random"
}

selectplaylist() {
    musicdir="$HOME/Music"
    fzfmenu=($(\ls -a $musicdir | fzf --prompt="$selectedartists : " --border=rounded --margin=5% --color=dark --height 100% --reverse --header="                    MUSIC " --info=hidden --header-first))
    if [ -z "$fzfmenu" ]; then
        exit 1
    fi
    x=1
    while [ $x -le 1 ]
    do
        if [ -z "$fzfmenu" ]; then
            x=$(( $x + 1 ))
        fi
        selectedartists="$selectedartists $fzfmenu"
        fzfmenu=($(\ls -a $musicdir | fzf --prompt="$selectedartists : " --border=rounded --margin=5% --color=dark --height 100% --reverse --header="                    MUSIC " --info=hidden --header-first))
    done
    mpc clear
    mpc rm favorites
    mpc update
    mpc add $selectedartists
    mpc shuffle
    mpc save favorites
    mpc play
    cd ~
    notify-send -t 2000 -a System "MPD" "Specifically Selected: $selectedartists"
}

reselect() {
    mpc clear
    mpc load favorites
    mpc shuffle
    mpc play
    notify-send -t 2000 -a System "MPD" "Playing Previous Selection"
}

case "$1" in
    -u) up ;;
    -d) down ;;
    -p) player ;;
    -s) loadstreambeats ;;
    -f) randomplaylist ;;
    -sp) selectplaylist ;;
    -r) reselect ;;
esac
