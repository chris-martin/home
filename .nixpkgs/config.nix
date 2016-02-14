{
  allowUnfree = true;

  chromium = {

    # Chromium's non-NSAPI alternative to Adobe Flash
    enablePepperFlash = true;

    enablePepperPDF = true;

    enableWideVine = true;
  };

  packageOverrides = pkgs_: with pkgs_; {
    all = with pkgs; buildEnv {
      name = "all";
      paths = [

        # Android
        jmtpfs

        # AWS
        awscli packer

        # Disk usage analysis
        baobab
        ncdu

        # Docker
        bridge-utils
        python27Packages.docker_compose

        # Document/image viewers
        evince gnome3.eog

        # Elixir
        elixir
        rebar

        # Gaming
        steam minecraft

        # Haskell
        haskellPackages.cabal2nix

        # Image editing
        gimp
        imagemagick
        inkscape
        #kde5.kcolorchooser

        # JS
        nodejs
        nodePackages.bower
        nodePackages.grunt-cli

        # JVM
        openjdk8 scala sbt gradle ant leiningen maven

        # Networking
        kde5.networkmanager-qt
        nmap

        # OCR
        tesseract

        # Password management
        keepassx2

        # Python
        python27Full python3
        python34Packages.pip
        python34Packages.ipython
        pypyPackages.virtualenv

        # Ruby
        ruby
        bundler

        # Screenshots
        scrot
        gnome3.gnome-screenshot

        # Video/audio
        ffmpeg
        gnome3.totem
        kde5.kmediaplayer
        kde5.plasma-pa
        vlc

        # Web browsers
        chromium # firefox

        idea."idea-ultimate"
        kde5.karchive
        kde5.konversation
        meld
        skype
        sshfsFuse
        transmission_gtk
        truecrypt
      ];
    };
  };
}
