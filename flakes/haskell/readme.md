This flake contains the [GHC] versions that I'm currently using the most and
want installed all the time.

I let most Haskell packages be managed by Cabal, but I use Nix to install a
package if it has native dependencies that Cabal cannot handle, or to take
advantage of Nix binary caching if package is an especially long compile.

The flake also includes [cabal] and [haskell-language-server].


  [GHC]: https://www.haskell.org/ghc/

  [cabal]: https://www.haskell.org/cabal/

  [haskell-language-server]: https://haskell-language-server.readthedocs.io/en/latest/
