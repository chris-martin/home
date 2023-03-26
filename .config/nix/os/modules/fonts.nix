{ pkgs, ... }:
{
    console.font = "Fira Mono";

    fonts = {
        fontDir.enable = true;
        enableGhostscriptFonts = true;
        fonts = [ pkgs.corefonts pkgs.fira-mono ];
    };
}
