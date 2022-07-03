haskell: self: super: {

#active = self.callPackage (import ./overrides/active.nix) {};
#aeson = haskell.lib.dontCheck super.aeson; # tests OOM on renzo
#aeson = self.callPackage (import ./overrides/aeson.nix) {};
#aeson-optics = self.callPackage (import ./overrides/aeson-optics.nix) {};
#diagrams-core = self.callPackage (import ./overrides/diagrams-core.nix) {};
#diagrams-lib = self.callPackage (import ./overrides/diagrams-lib.nix) {};
#dsv = self.callPackage (import ./overrides/dsv.nix) {};
#dual-tree = self.callPackage (import ./overrides/dual-tree.nix) {};
#foldl = self.callPackage (import ./overrides/foldl.nix) {};
#grab = self.callPackage (import ./overrides/grab.nix) {};
#grab-form = self.callPackage (import ./overrides/grab-form.nix) {};
#hashable = self.callPackage (import ./overrides/hashable.nix) {};
#hs-nix-modules = self.callPackage (import ./overrides/hs-nix-modules.nix) {};
#monoid-extras = self.callPackage (import ./overrides/monoid-extras.nix) {};
#mwc-random = self.callPackage (import ./overrides/mwc-random.nix) {};
#one-line-aeson-text = self.callPackage (import ./overrides/one-line-aeson-text.nix) {};
#optics = self.callPackage (import ./overrides/optics.nix) {};
#optics-core = self.callPackage (import ./overrides/optics-core.nix) {};
#optics-extra = self.callPackage (import ./overrides/optics-extra.nix) {};
#optics-th = self.callPackage (import ./overrides/optics-th.nix) {};
#random = self.callPackage (import ./overrides/random.nix) {};
#size-based = self.callPackage (import ./overrides/size-based.nix) {};
#stripe-concepts = self.callPackage (import ./overrides/stripe-concepts.nix) {};
#stripe-wreq = self.callPackage (import ./overrides/stripe-wreq.nix) {};
#svg-builder = self.callPackage (import ./overrides/svg-builder.nix) {};
#text-replace = self.callPackage (import ./overrides/text-replace.nix) {};
#vector = haskell.lib.dontCheck super.vector; # tests OOM on renzo

}
