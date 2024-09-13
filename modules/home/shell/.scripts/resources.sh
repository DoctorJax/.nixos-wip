#!/usr/bin/env bash

hyprctl dispatch exec '[workspace 11] kitty -e tmux attach'

while ! tmux run-shell ~/.config/tmux/plugins/tmux-resurrect/scripts/restore.sh; do sleep 0.2; done
