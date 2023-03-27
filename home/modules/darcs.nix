{ config, lib, pkgs, ... }:
with lib;
let cfg = config.programs.darcs;
in {
  imports = [ ];

  options = {
    programs.darcs = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "If enabled, install Darcs and config files.";
      };
      package = mkOption {
        type = types.package;
        default = pkgs.darcs;
        defaultText = literalExpression "pkgs.darcs";
        description = "The Darcs package to use.";
      };
      author = mkOption {
        type = types.listOf types.str;
        default = [ ];
        example = ''
          [ "Fred Bloggs <fred@example.net>" ]
        '';
      };
      boring = mkOption {
        type = types.listOf types.str;
        default = [ ];
        description = "File patterns to ignore";
      };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    { home.packages = [ cfg.package ]; }

    (mkIf (cfg.author != [ ]) {
      home.file.".darcs/author".text = concatStringsSep "\n" cfg.author;
    })

    (mkIf (cfg.boring != [ ]) {
      home.file.".darcs/boring".text = concatStringsSep "\n" cfg.boring;
    })

  ]);
}
