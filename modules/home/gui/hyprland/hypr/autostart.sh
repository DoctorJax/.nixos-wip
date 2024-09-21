# Fancy Stuff
/home/jackson/.scripts/wallpapers.sh -i &
ags &
swaync &

# Useful Stuff
/usr/bin/emacs --daemon &
nm-applet &

# Steam was being a pain
xrandr --output HDMI-A-1 --primary &

# MPD Stuff
pgrep -x mpd > /dev/null || mpd /home/jackson/.config/mpd/mpd.conf &
pgrep -x mpd-mpris > /dev/null || mpd-mpris &

# Run Once
pgrep -x companion.sh > /dev/null || /home/jackson/.scripts/companion.sh &

# Polkit
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & eval "$(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)" &
