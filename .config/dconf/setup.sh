#!/usr/bin/env bash
dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/use-custom-command true
dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/custom-command "'tmux'"
dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/scrollbar-policy "'never'"
dconf write /org/gnome/desktop/peripherals/keyboard/repeat-interval 'uint32 20'
dconf write /org/gnome/desktop/peripherals/keyboard/delay 'uint32 300'
dconf write /org/gnome/desktop/wm/preferences/mouse-button-modifier "'<Alt>'"
