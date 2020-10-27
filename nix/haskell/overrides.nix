self: super: {

aeson-optics = self.callPackage (import ./overrides/aeson-optics.nix) {};
dsv = self.callPackage (import ./overrides/dsv.nix) {};
grab = self.callPackage (import ./overrides/grab.nix) {};
grab-form = self.callPackage (import ./overrides/grab-form.nix) {};
hs-nix-modules = self.callPackage (import ./overrides/hs-nix-modules.nix) {};
optics = self.callPackage (import ./overrides/optics.nix) {};
optics-core = self.callPackage (import ./overrides/optics-core.nix) {};
optics-extra = self.callPackage (import ./overrides/optics-extra.nix) {};
optics-th = self.callPackage (import ./overrides/optics-th.nix) {};
size-based = self.callPackage (import ./overrides/size-based.nix) {};
stripe-concepts = self.callPackage (import ./overrides/stripe-concepts.nix) {};
stripe-wreq = self.callPackage (import ./overrides/stripe-wreq.nix) {};
svg-builder = self.callPackage (import ./overrides/svg-builder.nix) {};

}
