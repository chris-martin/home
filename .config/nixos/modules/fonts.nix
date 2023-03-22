{ pkgs, ... }:
{
    console.font = "Fira Mono";

    fonts = {
        fontDir.enable = true;
        enableGhostscriptFonts = true;

        fonts = [
          pkgs.corefonts
          pkgs.fira
          pkgs.fira-code
          pkgs.fira-mono
          pkgs.lato
          pkgs.inconsolata
          pkgs.profont
          pkgs.source-sans-pro
          pkgs.source-serif-pro
          pkgs.symbola
          pkgs.ubuntu_font_family
          pkgs.unifont
          pkgs.vistafonts
        ];
    };
}
