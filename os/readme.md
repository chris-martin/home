This directory contains the bulk of the NixOS configuration.

My two machines are [cubby](./cubby) and [renzo](./renzo).

More information:

* See the readme files in the subdirectories
* [NixOS options search](https://search.nixos.org/options)
* [Nix packages search](https://search.nixos.org/packages)

For example, to update `hoogle` on `cubby`:

```fish
~/.config/nix/os> nix flake lock --update-input nixpkgs-for-hoogle-cubby
~/.config/nix/os> sudo nixos-rebuild --flake . switch --builders '@../builders'
```
