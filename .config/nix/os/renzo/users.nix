{
    users.extraUsers.chris = {
        isNormalUser = true;
        description = "Chris Martin";
        extraGroups = [
          "audio" "disk" "docker" "networkmanager" "plugdev"
          "systemd-journal" "wheel" "vboxusers" "video"
        ];
        uid = 1000;
    };
}