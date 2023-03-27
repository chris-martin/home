This directory lives at `/home/chris/.config/nix`.

Each directory herein is a [flake](https://nixos.wiki/wiki/Flakes).

My two machines are [cubby](./cubby) and [renzo](./renzo).


## Resources

* [My Substack post introducing Flakes](https://typeclasses.substack.com/p/flakes-nixos-desktop)
* [Home Manager manual](https://nix-community.github.io/home-manager/)
* [Home Manager configuration options](https://nix-community.github.io/home-manager/options.html)
* [NixOS options search](https://search.nixos.org/options)
* [Nix packages search](https://search.nixos.org/packages)


## A few example commands

For example, to update the `home` config:

```fish
fish> nix flake lock --update-input home /home/chris/.config/nix/(hostname)
fish> sudo nixos-rebuild --flake /home/chris/.config/nix/(hostname) switch
```


## Notes about packages

Favorite packages from nixpkgs:

- `abcde` -- audio CD ripping
- `ack`
- `alsaUtils`
- `alsamixer` -- audio controls
- `ansifilter`
- `audacity`
- `arcanist`
- `astyle`
- `awscli`
- `binutils`
- `calibre`
- `cheese` -- Camera GUI
- `chromium`
- `discord`
- `dmenu`
- `entr`
- `ffmpeg-full`
- `ffmpegthumbnailer`
- `fontforge`
- `gnome3.dconf-editor`
- `gnome3.gedit`
- `ghostscript`
- `gimp` -- image editor
- `gitAndTools.gitFull`
- `git-filter-repo`
- `gksu`
- `glances`
- `gmrun`
- `gnome-screenshot`
- `gnome3.gnome-terminal`
- `gnucash` -- accounting
- `gnumake` -- make
- `go`
- `google-chrome`
- `graphviz`
- `guvcview` -- for recording from a webcam
- `imagemagick` -- CLI image editor
- `inkscape` -- SVG editor
- `intellij` -- IntelliJ IDEa
- `inxi`
- `iw` -- wireless network manager
- `jmtpfs` -- Android filesystem mounting
- `jq`
- `kcolorchooser`
- `kdenlive`
- `konsole`
- `libnotify`
- `libreoffice`
- `lynx`
- `minecraft`
- `mlt`
- `moc` -- "music on console" CLI music player
- `moreutils`
- `mpv` -- video player
- `mtools`
- `nautilus`
- `ncdu`
- `netcat-gnu`
- `nix-prefetch-scripts`
- `nix-repl` -- REPL for the Nix language
- `nodejs` -- javascript repl
- `obs-studio`
- `okular` -- PDF viewer
- `ormolu`
- `pandoc`
- `pandora` -- internet music
- `pass`
- `pciutils`
- `pdftk`
- `pssh`
- `python3`
- `python3Packages.ipython` -- Python REPL
- `rlwrap`
- `rip-cd`
- `sassc`
- `scrot` -- screenshot tool
- `slack`
- `solaar`
- `sshfs-fuse` -- SSH mount
- `socat`
- `stack2nix`
- `stylish-haskell` -- Haskell code formatter
- `sublime` -- text editor
- `sws`
- `system-config-printer`
- `telnet`
- `tesseract` -- OCR
- `(pkgs.texlive.combine { inherit (pkgs.texlive) scheme-small; })`
- `pkgs.text-replace`
- `totem`
- `traceroute`
- `transmission_gtk` -- bittorrent
- `usbutils`
- `unetbootin`
- `wezterm`
- `wine`
- `woff2`
- `xorg.xev`
- `xournal` -- PDF editor
- `zoom-us`
