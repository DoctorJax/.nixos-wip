#!/usr/bin/env bash
set -e

conInput="wav"
conOutput="ogg"

if [[ -n "$2" ]]
then
    conInput="$2"
fi

if [[ -n "$3" ]]
then
    conOutput="$3"
fi

short() {
    # Does the music conversion but adds new lines to output file names
    for b in *.$conInput
    do
        ffmpeg -i "$b" "$(basename --suffix=.$conInput $b)".$conOutput
    done
    
    # Should fix the file names too
    for i in *
    do
        IN=$(basename --suffix=.$conOutput "$i")
        OUT=$(echo $IN | tr "$\'" '-' | sed 's/---\\n--/-/g')
        echo "$OUT"
        if [[ "$IN" != "$OUT" ]]
        then
            mv "$IN".$conOutput "$OUT".$conOutput
        fi
    done
    rm -rf *.$conInput
}

recursive() { 
    # Does the music conversion but adds new lines to output file names
    for a in ./*
    do
        cd "$a"/
        for b in *.$conInput
        do
            ffmpeg -i "$b" "$(basename --suffix=.$conInput $b)".$conOutput
        done
        cd ../
    done
    
    # Should fix the file names too
    for d in ./*
    do
        cd "$d"/
        for i in *
        do
            IN=$(basename --suffix=.$conOutput "$i")
            OUT=$(echo $IN | tr "$\'" '-' | sed 's/---\\n--/-/g')
            echo "$OUT"
            if [[ "$IN" != "$OUT" ]]
            then
                mv "$IN".$conOutput "$OUT".$conOutput
            fi
        done
        rm -rf *.$conInput
        cd ../
    done
}

help() {
    printf "\n Use -s for a short conversion in the current folder or -r for folders inside this folder. \n By default it converts wav to ogg but you can change that by including the extensions after options. \n Example: 'musiccon.sh -s wav ogg' \n"
}

case "$1" in
    -h) help ;;
    -r) recursive ;;
    -s) short ;;
esac
