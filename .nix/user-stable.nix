{
  allowUnfree = true;

  packageOverrides = pkgs_: with pkgs_; {
    all-stable = with pkgs; buildEnv {
      name = "all-stable";
      paths = [

        # Android
        #jmtpfs

        # AWS
        awscli packer

        # Disk usage analysis
        baobab
        ncdu

        # Document/image viewers
        evince gnome3.eog

        # Editors
        sublime3
        vim

        # Elixir
        # elixir
        # rebar

        # Gaming
        # steam
        # minecraft

        # Image editing
        # gimp
        # imagemagick
        # inkscape

        # IRC
        gnome3.polari
        kde4.konversation

        # JS
        # nodejs
        # nodePackages.bower
        # nodePackages.grunt-cli

        # JVM
        # ant
        # gradle
        # leiningen
        # openjdk8
        # sbt
        # scala
        # maven

        # Networking
        nmap

        # OCR
        #tesseract

        # Password management
        keepassx2

        # Python
        #python34Packages.ipython
        #pypyPackages.virtualenv

        # Ruby
        ruby
        bundler

        # Screenshots
        scrot
        gnome3.gnome-screenshot

        # Video/audio
        #ffmpeg
        #gnome3.totem
        #vlc

        # Zip
        zip
        unzip

        fish
        gitAndTools.gitFull
        #gnome3.file-roller
        jq
        #meld
        nix-repl
        psmisc
        #skype
        sshfsFuse
        tmux
        #transmission_gtk
        #truecrypt
        xclip
        xorg.xkill
      ];
    };
  };
}
