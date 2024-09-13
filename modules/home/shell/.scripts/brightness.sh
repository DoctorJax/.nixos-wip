#!/usr/bin/env bash

up() {
    xbacklight -inc 10
    notify-send -t 2000 -a System "Screen Brightness" "$(xbacklight -get)"
}

down() {
    xbacklight -dec 10
    notify-send -t 2000 -a System "Screen Brightness" "$(xbacklight -get)"
}

case "$1" in
    -u) up;;
    -d) down;;
esac
