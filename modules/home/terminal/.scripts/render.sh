#!/usr/bin/env bash

set -e

if [[ "$1" == "-h" ]]
then
    printf "\n Usage: render.sh <file> \n Note: Must be run in the same folder as the file \n"
    exit
fi

render() {
    sed -i 's|<track producer="black_track"/>||g' "$1"
    
    filename=$(echo "$1" | awk -F '.' '{print $1}')

    notify-send -t 2000 -a System "Render.sh" "Rendering Started"

    melt "$1" -progress -consumer avformat:"$filename".mp4 real_time=-14 movflags=+faststart vcodec=h264_nvenc progressive=1 g=15 bf=2 cq=23 acodec=aac ab=192k

    notify-send -t 2000 -a System "Render.sh" "Rendering Ended"
}

render "$@"
