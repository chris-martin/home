{
  allowUnfree = true;

  packageOverrides = pkgs_: with pkgs_; {
    all-stable = with pkgs; buildEnv {
      name = "all-stable";
      paths = [

        # Android
        jmtpfs

        # Archives
        zip
        unzip
        gnome3.file-roller

        # AWS
        awscli packer

        # Crypto
        keepassx2
        truecrypt

        # Disk usage analysis
        baobab
        ncdu

        # Document/image viewers
        evince gnome3.eog

        # Elixir
        elixir
        rebar

        # Gaming
        minecraft

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

        # Python
        python27Full
        python3
        python34Packages.ipython
        pypyPackages.virtualenv

        # Ruby
        ruby
        bundler

        # Screenshots
        scrot
        gnome3.gnome-screenshot

        # Torrent
        transmission_gtk

        # Video/audio
        alsamixer
        ffmpeg
        gnome3.totem
        gstreamer
        vlc

        fish
        gitAndTools.gitFull
        jq
        meld
        nix-repl
        pciutils
        psmisc
        skype
        sshfsFuse
        texLiveFull
        tmux
        which
        vim
        xclip
        xorg.xkill
      ];
    };
  };
}
