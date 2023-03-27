{ config, pkgs, ... }:

{
    programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
    };

    services.openssh = {
        enable = true;
        passwordAuthentication = false;
    };
}
