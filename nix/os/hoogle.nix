{ pkgs, ... }:
{
  services.hoogle.enable = true;
  services.hoogle.port = 13723;
  services.hoogle.haskellPackages = (import <nixpkgs> { }).haskellPackages;
  services.hoogle.packages = p: [
    p.acme-functors
    p.aeson
    #p.aeson-decode
    #p.aeson-optics
    p.appendmap
    p.async
    #p.atomic-modify
    p.base16-bytestring
    p.blaze-html
    p.blaze-markup
    #p.bricks
    #p.Chart
    #p.Chart-cairo
    #p.choose
    #p.choose-exe
    p.cookie
    p.conduit-combinators
    p.cryptonite
    #p.data-forest
    p.Decimal
    p.diagrams
    #p.either-list-functions
    p.filemanip
    #p.fizzbuzz-as-a-service
    p.foldl
    p.fsnotify
    p.gd
    p.gtk3
    p.hashable
    p.hedgehog
    p.hex-text
    #p.hnix
    #p.html-entities
    p.http-client
    p.http-client-tls
    p.http-conduit
    p.http-types
    p.ini
    p.lens
    p.lens-aeson
    p.loc
    p.loc-test
    p.lucid
    p.markdown
    p.megaparsec
    p.memory
    p.monad-gen
    #p.multi-instance
    #p.mvar-lock
    p.neat-interpolation
    p.network
    p.network-simple
    p.network-uri
    p.one-line-aeson-text
    p.one-liner
    p.opaleye
    p.optics
    p.optparse-applicative
    p.optparse-generic
    #p.pam
    p.pandoc
    p.pandoc-types
    p.parser-combinators
    #p.partial-semigroup
    #p.partial-semigroup-hedgehog
    p.path
    p.path-io
    #p.path-text-utf8
    p.pipes
    p.pipes-attoparsec
    p.pipes-bytestring
    p.pipes-http
    p.pipes-safe
    #p.pipes-text
    p.postgresql-simple
    #p.postmark
    p.profunctors
    p.QuickCheck
    p.random
    p.relude
    p.resource-pool
    p.resourcet
    #p.rss
    p.safe-exceptions
    #p.safe-money
    p.scotty
    #p.semialign
    #p.stm-containers
    #p.stripe-concepts
    #p.stripe-scotty
    #p.stripe-signature
    #p.stripe-wreq
    p.these
    p.template
    p.test-framework
    #p.text-replace
    p.turtle
    p.unordered-containers
    p.utf8-string
    p.validation
    p.var-monad
    p.vector
    p.wai
    p.warp
    p.wreq
    p.X11
    p.xmonad
  ];
}
