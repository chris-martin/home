{ pkgs, stdenv, buildPerlPackage, fetchurl, fetchFromGitHub, perlPackages }:

let

  Tk = buildPerlPackage rec {
    name = "Tk-804.032";
    src = fetchurl {
      url = "http://search.cpan.org/CPAN/authors/id/S/SR/SREZIC/${name}.tar.gz";
      sha256 = "0jarvplhfvnm0shhdm2a5zczlnk9mkf8jvfjiwyhjrr3cy1gl0w0";
    };
    makeMakerFlags = "X11LIB=${pkgs.xorg.libX11.out}/lib";
    buildInputs = with pkgs; [ xorg.libX11 libpng ];
    configurePhase = ''
      perl Makefile.PL PREFIX=$out $makeMakerFlags
    '';
    doCheck = false;
    meta ={
      homepage = "http://search.cpan.org/~srezic/Tk-804.032/Tk.pod";
      license = stdenv.lib.licenses.tcltk;
    };
  };
in
buildPerlPackage rec {
  name = "clusterssh-${version}";
  version = "4.08";
  src = fetchFromGitHub {
    owner = "duncs";
    repo = "clusterssh";
    rev = "release-${version}";
    sha256 = "1blv64clc0i63fyxy68j736gmvaaq5wlj8yf5ql3vn812lxr1c62";
  };
  propagatedBuildInputs = [ Tk ] ++ (with perlPackages; [
    ExceptionClass
    #FileGlob
    FilePath
    #Getopt
    LocaleMaketext
    TryTiny
    X11Protocol
    #X11ProtocolWM
  ]);
  meta = with stdenv.lib; {
    description = "Cluster Admin Via SSH";
    homepage    = https://github.com/duncs/clusterssh;
    license     = licenses.gpl;
    maintainers = with maintainers; [ chris-martin ];
    platforms   = platforms.unix;
  };
}
