{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.programs.darcs;
in
{
    imports = [];

    options = {
        programs.darcs = {
            enable = mkOption {
                type = types.bool;
                default = false;
                description = "If enabled, write Darcs config files.";
            };
            authors = mkOption {
                type = types.listOf types.str;
                default = [];
                example = ''
                    [ "Fred Bloggs <fred@example.net>" ]
                '';
            };
            boring = mkOption {
                type = types.listOf types.str;
                default = [];
                description = "File patterns to ignore";
            };
        };
    };

    config = mkIf cfg.enable (mkMerge [

        {
            home.file.".darcs/author".text = concatStringsSep "\n" cfg.authors;
        }

        {
            home.file.".darcs/boring".text = concatStringsSep "\n" cfg.boring;
        }

    ]);
}
