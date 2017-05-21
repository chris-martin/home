#!/usr/bin/env bash

./setup-base.sh

dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/font "'Monospace 12'"
dconf write /org/gnome/desktop/interface/font-name          "'Cantarell 13'"
dconf write /org/gnome/desktop/interface/document-font-name "'Lato Medium 13'"
dconf write /org/gnome/desktop/wm/preferences/titlebar-font "'Lato Bold 13'"

dconf write /org/gnome/desktop/wm/preferences/resize-with-right-button true
dconf write /org/gnome/desktop/wm/preferences/mouse-button-modifier "'<Alt>'"

