#!/usr/bin/env bash

micmute() {
    amixer set Capture toggle
    notify-send -i /home/jackson/Pictures/white-micicon.png -t 4000 -a System "Microphone" "$(amixer get Capture | tail -n1)"
}

micmute
