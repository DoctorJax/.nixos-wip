#!/usr/bin/env bash

#headphones_sink="alsa_output.usb-Corsair_CORSAIR_VOID_ELITE_Wireless_Gaming_Dongle-00.analog-stereo"
#earbuds_sink="alsa_output.pci-0000_0e_00.6.analog-stereo"
#speaker_sink="alsa_output.usb-Dell_Dell_AC511_USB_SoundBar-00.3.analog-stereo"
#wireless_earbuds_sink="alsa_output.usb-Harman_International_Inc_JBL_Quantum_TWS_0000000000000000-00.analog-stereo"

headphones_sink="alsa_output.usb-Corsair_CORSAIR_VOID_ELITE_Wireless_Gaming_Dongle-00.analog-stereo"
earbuds_sink=$(pactl list sinks | grep "Name: " | awk '{ print $2 }' | grep "pci")
speaker_sink=$(pactl list sinks | grep "Name: " | awk '{ print $2 }' | grep "Dell")
wireless_earbuds_sink="alsa_output.usb-Telink_VR_P10_Dongle-00.analog-stereo"

wireless_earbuds() {
    pactl set-default-sink $wireless_earbuds_sink
    notify-send -t 2000 -a System "Audio Swap" "Default Sink: Wireless Earbuds"
}

headphones() {
    pactl set-default-sink $headphones_sink
    headsetcontrol -l 0
    notify-send -t 2000 -a System "Audio Swap" "Default Sink: Headphones"
}

earbuds() {
    pactl set-default-sink $earbuds_sink
    notify-send -t 2000 -a System "Audio Swap" "Default Sink: Earbuds"
}

speaker() {
    pactl set-default-sink $speaker_sink
    notify-send -t 2000 -a System "Audio Swap" "Default Sink: Speakers"
}

togglesink() {
    if [[ $(pactl list sinks | grep -Eo "$headphones_sink" | head -1) = "$headphones_sink" ]]; then
        headphones
    elif [[ $(pactl list sinks | grep -Eo "$wireless_earbuds_sink" | head -1) = "$wireless_earbuds_sink" ]]; then
        wireless_earbuds
    else
        pactl get-default-sink | grep $speaker_sink && earbuds || speaker
    fi
}

case "$1" in
    -h) headphones;;
    -e) earbuds;;
    -we) wireless_earbuds;;
    -t) togglesink;;
    -s) speaker;;
esac
