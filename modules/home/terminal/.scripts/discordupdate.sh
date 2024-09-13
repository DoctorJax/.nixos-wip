#!/usr/bin/bash

DISCORD_PATH="$HOME/.local/bin/.discord-canary"

update() {
    pkill -9 DiscordCanary

    cd "$DISCORD_PATH"

    rm -r DiscordCanary discord-canary.tar.gz

    wget "https://discord.com/api/download/canary?platform=linux&format=tar.gz" -O discord-canary.tar.gz

    tar xvf discord-canary.tar.gz

    ./DiscordCanary/DiscordCanary &

    sleep 6

    pkill -9 DiscordCanary

    updateopenasar

    theme
}

updateopenasar() {
    cd "$DISCORD_PATH"

    wget 'https://github.com/GooseMod/OpenAsar/releases/download/nightly/app.asar'
    mv app.asar "$DISCORD_PATH"/DiscordCanary/resources/app.asar

    pkill -9 DiscordCanary
}

theme() {
    cp "$DISCORD_PATH"/settings.json "$HOME"/.config/discordcanary/settings.json

    pkill -9 DiscordCanary
}

case "$1" in
    -uo) updateopenasar ;;
    -u) update ;;
    -t) theme ;;
    -a) update ;;
    *) update ;;
esac
