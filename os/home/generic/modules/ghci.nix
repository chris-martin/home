{ config, lib, pkgs, ... }:
with lib;
let cfg = config.programs.ghci;
in {
  imports = [ ];

  options = {
    programs.ghci = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "If enabled, write GHCi config file.";
      };
      prompt = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Command prompt";
      };
      promptContinue = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Command prompt for subsequent lines after the first";
      };
      multiline = mkOption {
        type = types.bool;
        default = false;
        description = "Allow multiline commands";
      };
    };
  };

  config = mkIf cfg.enable (mkMerge [

    {
      home.file.".ghc/ghci.conf".text = concatStrings [
        (optionalString (cfg.prompt != null) ''
          :set prompt "${cfg.prompt}"
        '')
        (optionalString (cfg.promptContinue != null) ''
          :set prompt-cont "${cfg.promptContinue}"
        '')
        (optionalString cfg.multiline ''
          :set +m
        '')
      ];
    }

  ]);
}
