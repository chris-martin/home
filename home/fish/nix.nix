let os-flake = "/home/chris/.config/nix/(hostname)";
in {
  programs.fish = {
    shellAbbrs = {
      os-flake = "echo ${os-flake}";
      os-switch = "sudo nixos-rebuild --flake ${os-flake} switch";
      os-update = "nix flake lock ${os-flake} --update-input";
      os-update-all = "nix flake update ${os-flake}";
    };
  };
}
