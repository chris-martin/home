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

        # Editors
        (emacsWithPackages (epkgs: [
          epkgs.flycheck
          epkgs.flycheck-haskell
          epkgs.magit
          epkgs.neotree
          epkgs.projectile
          epkgs.tabbar
          epkgs.ws-butler
          epkgs.markdown-mode
        ]))
        idea."idea-ultimate"
        sublime3
        vim

        # Elixir
        elixir
        rebar

        # Gaming
        steam
        minecraft

        # Haskell
        haskellPackages.stack

        # Image editing
        gimp
        imagemagick
        inkscape

        # IRC
        gnome3.polari
        kde4.konversation

        # JS
        nodejs
        nodePackages.bower
        nodePackages.grunt-cli

        # JVM
        ant
        gradle
        leiningen
        openjdk8
        sbt
        scala
        maven

        # Networking
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
        vlc

        # Web browsers
        chromium

        gnome3.file-roller
        meld
        skype
        sshfsFuse
        transmission_gtk
        truecrypt
      ];
    };
  };
}
