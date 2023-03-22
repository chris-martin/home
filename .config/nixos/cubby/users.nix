{ config, pkgs, ... }:
{

  users.users = {
      chris = {
          isNormalUser = true;
          description = "Chris Martin";
          extraGroups = ["wheel"];
          uid = 1000;
          openssh.authorizedKeys.keys = import ../keys.nix;
          shell = pkgs.fish;
      };
      julie = {
          isNormalUser = true;
          description = "Julie Moronuki";
          uid = 1001;
      };
  };

  home-manager.users.chris = import /home/chris/.config/home-manager/config.nix;

}
