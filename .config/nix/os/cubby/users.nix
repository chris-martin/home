{
    users.users = {
        chris = {
            isNormalUser = true;
            description = "Chris Martin";
            extraGroups = ["wheel"];
            uid = 1000;
            openssh.authorizedKeys.keys = import ../keys.nix;
        };
        julie = {
            isNormalUser = true;
            description = "Julie Moronuki";
            uid = 1001;
        };
    };
}
