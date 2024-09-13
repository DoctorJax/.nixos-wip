#!/usr/bin/env bash

recordmic_path="/home/jackson/Videos/YouTube/StreamElements/SoundBoard/micrecordings"
recorddesk_path="/home/jackson/Videos/YouTube/StreamElements/SoundBoard/deskrecordings"
play_path="/home/jackson/Videos/YouTube/StreamElements/SoundBoard"

recordmic() {
    notify-send -t 2000 -a System "Sounds.sh" "Microphone Recording Started"
    arecord --device="hw:4,0" -f dat "$recordmic_path/rec_$(date '+%F_%H-%M-%S').wav"
}

recorddesk() {
    notify-send -t 2000 -a System "Sounds.sh" "Desktop Recording Started"
    parec -d "$(pactl get-default-sink).monitor" | lame -r -V0 - "$recorddesk_path/rec_$(date '+%F_%H-%M-%S').mp3"
}

micrecent() {
    latestmic=$(find "$recordmic_path" | tail -n1)
    mpv "$latestmic"
}

deskrecent() {
    latestdesk=$(find "$recorddesk_path" | tail -n1)
    mpv "$latestdesk"
}

play() {
    mpv $file
}

case "$1" in
    -1) mpv "" ;;
    -2) mpv "" ;;
    -3) mpv "" ;;
    -4) mpv "" ;;
    -5) mpv "" ;;
    -6) mpv "" ;;
    -m) recordmic ;;
    -d) recorddesk ;;
    -mr) micrecent ;;
    -dr) deskrecent ;;
esac
