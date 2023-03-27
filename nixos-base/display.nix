{ ... }:
{
    services.xserver.displayManager.sessionCommands = ''
        dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/use-custom-command true
        dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/use-system-font false
        dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/font "'Monospace 14'"
        dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/cursor-shape "'block'"
        dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/custom-command "'fish'"
        dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/scrollbar-policy "'never'"
        dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/audible-bell false

        dconf write /org/gnome/desktop/peripherals/keyboard/repeat-interval 'uint32 20'
        dconf write /org/gnome/desktop/peripherals/keyboard/delay 'uint32 300'

        dconf write /org/gnome/terminal/legacy/default-show-menubar false

        dconf write /org/gtk/settings/file-chooser/clock-format "'12h'"

        dconf write /org/gnome/desktop/interface/clock-show-date true
        dconf write /org/gnome/desktop/interface/font-name "'Cantarell 11'"
        dconf write /org/gnome/desktop/interface/document-font-name "'Lato Medium 11'"
        dconf write /org/gnome/desktop/interface/clock-format "'12h'"
        dconf write /org/gnome/desktop/interface/clock-show-seconds false

        dconf write /org/gnome/desktop/wm/preferences/mouse-button-modifier "'<Alt>'"
        dconf write /org/gnome/desktop/wm/preferences/titlebar-font "'Lato Bold 11'"
        dconf write /org/gnome/desktop/wm/preferences/resize-with-right-button true
        dconf write /org/gnome/desktop/wm/preferences/focus-mode "'click'"
        dconf write /org/gnome/desktop/wm/keybindings/switch-windows "['<Alt>Tab']"
        dconf write /org/gnome/desktop/wm/keybindings/switch-windows-backward "['<Alt><Shift>Tab']"
    '';
}
