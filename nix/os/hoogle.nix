{ pkgs, ... }:
{
  services.hoogle.enable = true;
  services.hoogle.port = 13723;
  services.hoogle.haskellPackages = (import <nixpkgs> { }).haskellPackages;
  services.hoogle.packages = p: [
    p.acme-functors
    p.aeson
    #p.aeson-decode
    p.async
    #p.atomic-modify
    p.base16-bytestring
    p.binary
    p.blaze-html
    p.blaze-markup
    #p.bricks
    p.bytestring
    p.choose
    p.choose-exe
    p.cookie
    p.conduit-combinators
    p.containers
    p.cryptonite
    #p.data-forest
    p.Decimal
    p.directory
    #p.ede
    #p.either-list-functions
    p.filemanip
    #p.fizzbuzz-as-a-service
    p.gd
    p.gtk3
    p.hashable
    p.hedgehog
    #p.hex-text
    #p.html-entities
    p.http-client
    p.http-client-tls
    p.http-conduit
    p.http-types
    p.lens
    p.lens-aeson
    #p.loc
    #p.loc-test
    p.lucid
    p.markdown
    p.megaparsec
    p.memory
    p.mtl
    #p.multi-instance
    #p.mvar-lock
    p.neat-interpolation
    p.network-uri
    #p.one-line-aeson-text
    p.one-liner
    p.optparse-applicative
    p.optparse-generic
    #p.pam
    p.pandoc
    p.pandoc-types
    p.parser-combinators
    #p.partial-semigroup
    #p.partial-semigroup-hedgehog
    #p.partial-semigroup-test
    p.path-text-utf8
    p.postgresql-simple
    #p.postmark
    p.profunctors
    p.QuickCheck
    p.random
    #p.reflex
    #p.reflex-dom
    p.resource-pool
    p.resourcet
    #p.rss
    p.safe-exceptions
    p.scotty
    p.stm
    #p.stm-containers
    p.stripe-core
    p.stripe-haskell
    p.stripe-http-streams
    p.template
    p.text
    p.text-replace
    p.time
    p.transformers
    p.turtle
    p.unordered-containers
    p.utf8-string
    p.validation
    p.var-monad
    p.vector
    p.wai
    p.warp
    p.wreq
    p.xmonad
    p.yi-core
    p.yi-keymap-cua
    p.yi-keymap-vim
    p.yi-misc-modes
    p.yi-mode-haskell
    p.yi-mode-javascript
  ];
}
