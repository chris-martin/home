{ config, ... }: {

  xdg.userDirs = {
    enable = true;
    createDirectories = false;
    desktop = "${config.home.homeDirectory}/desktop";
    documents = "${config.home.homeDirectory}/documents";
    download = "${config.home.homeDirectory}/download";
    music = "${config.home.homeDirectory}/music";
    pictures = "${config.home.homeDirectory}/pictures";
    publicShare = "${config.home.homeDirectory}/public";
    templates = "${config.home.homeDirectory}/templates";
    videos = "${config.home.homeDirectory}/videos";
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {

      # PDF
      "application/pdf" = [ "evince.desktop" ];

      # Web
      "application/x-extension-htm" = [ "firefox.desktop" ];
      "application/x-extension-html" = [ "firefox.desktop" ];
      "application/x-extension-shtml" = [ "firefox.desktop" ];
      "application/x-extension-xht" = [ "firefox.desktop" ];
      "application/x-extension-xhtml" = [ "firefox.desktop" ];
      "application/xhtml+xml" = [ "firefox.desktop" ];
      "text/html" = [ "firefox.desktop" ];
      "x-scheme-handler/about" = [ "firefox.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
      "x-scheme-handler/mailto" = [ "firefox.desktop" ];
      "x-scheme-handler/unknown" = [ "firefox.desktop" ];
      "x-scheme-handler/webcal" = [ "firefox.desktop" ];

      # Images
      "image/bmp" = [ "eog.desktop" ];
      "image/gif" = [ "eog.desktop" ];
      "image/jpeg" = [ "eog.desktop" ];
      "image/jpg" = [ "eog.desktop" ];
      "image/pjpeg" = [ "eog.desktop" ];
      "image/png" = [ "eog.desktop" ];
      "image/svg+xml-compressed" = [ "eog.desktop" ];
      "image/svg+xml" = [ "eog.desktop" ];
      "image/tiff" = [ "eog.desktop" ];
      "image/vnd.wap.wbmp" = [ "eog.desktop" ];
      "image/x-bmp" = [ "eog.desktop" ];
      "image/x-gray" = [ "eog.desktop" ];
      "image/x-icb" = [ "eog.desktop" ];
      "image/x-icns" = [ "eog.desktop" ];
      "image/x-ico" = [ "eog.desktop" ];
      "image/x-pcx" = [ "eog.desktop" ];
      "image/x-png" = [ "eog.desktop" ];
      "image/x-portable-anymap" = [ "eog.desktop" ];
      "image/x-portable-bitmap" = [ "eog.desktop" ];
      "image/x-portable-graymap" = [ "eog.desktop" ];
      "image/x-portable-pixmap" = [ "eog.desktop" ];
      "image/x-xbitmap" = [ "eog.desktop" ];
      "image/x-xpixmap" = [ "eog.desktop" ];
    };

    # This is a huge mess!
    associations.added = {
      "application/atom+xml" = [ "firefox.desktop" ];
      "application/epub+zip" = [
        "org.gnome.FileRoller.desktop"
        "org.gnome.gedit.desktop"
        "calibre.desktop"
        "okularApplication_epub.desktop"
      ];
      "application/json" = [ "org.gnome.gedit.desktop" ];
      "application/octet-stream" =
        [ "org.inkscape.Inkscape.desktop" "inkscape.desktop" "calc.desktop" ];
      "application/pdf" = [
        "org.gnome.Evince.desktop"
        "okularApplication_pdf.desktop"
        "draw.desktop"
        "qpdfview.desktop"
        "inkscape.desktop"
        "evince.desktop"
      ];
      "application/postscript" = [ "org.gnome.Evince.desktop" ];
      "application/rss+xml" = [ "org.gnome.gedit.desktop" "firefox.desktop" ];
      "application/vnd.apple.mpegurl" = [ "org.gnome.gedit.desktop" ];
      "application/vnd.oasis.opendocument.text" = [ "writer.desktop" ];
      "application/vsix" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-7z-compressed" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-compressed-tar" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-dvi" = [ "okularApplication_djvu.desktop" ];
      "application/x-extension-htm" = [ "firefox.desktop" ];
      "application/x-extension-html" = [ "firefox.desktop" ];
      "application/x-extension-shtml" = [ "firefox.desktop" ];
      "application/x-extension-xht" = [ "firefox.desktop" ];
      "application/x-extension-xhtml" = [ "firefox.desktop" ];
      "application/x-gzpdf" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-kdenlive" =
        [ "org.kde.kdenlive.desktop" "org.gnome.gedit.desktop" ];
      "application/x-mobipocket-ebook" =
        [ "org.gnome.FileRoller.desktop" "org.gnome.gedit.desktop" ];
      "application/x-ms-dos-executable" = [ "wine-extension-msp.desktop" ];
      "application/x-shellscript" = [ "org.gnome.gedit.desktop" ];
      "application/x-x509-ca-cert" = [ "org.gnome.gedit.desktop" ];
      "application/x-xz-compressed-tar" = [ "org.gnome.FileRoller.desktop" ];
      "application/xhtml+xml" = [ "org.gnome.gedit.desktop" "firefox.desktop" ];
      "application/xml" = [ "org.gnome.gedit.desktop" ];
      "application/zip" =
        [ "org.gnome.FileRoller.desktop" "sublime_text.desktop" ];
      "audio/mpeg" = [ "org.gnome.Totem.desktop" ];
      "audio/x-vorbis+ogg" = [ "mpv.desktop" "org.gnome.Totem.desktop" ];
      "audio/x-wav" = [ "org.gnome.Totem.desktop" "audacity.desktop" ];
      "binary/octet-stream" = [ "org.gnome.gedit.desktop" ];
      "font/otf" =
        [ "org.gnome.font-viewer.desktop" "org.gnome.gedit.desktop" ];
      "image/bmp" = [ "eog.desktop" ];
      "image/gif" = [ "org.gnome.eog.desktop" "eog.desktop" ];
      "image/jpeg" = [
        "org.gnome.eog.desktop"
        "gimp.desktop"
        "org.inkscape.Inkscape.desktop"
        "eog.desktop"
        "inkscape.desktop"
      ];
      "image/jpg" = [ "eog.desktop" ];
      "image/pjpeg" = [ "eog.desktop" ];
      "image/png" = [
        "org.gnome.eog.desktop"
        "gimp.desktop"
        "org.gnome.Evince.desktop"
        "inkscape.desktop"
        "eog.desktop"
        "org.gnome.gedit.desktop"
        "feh.desktop"
      ];
      "image/svg+xml-compressed" = [ "eog.desktop" ];
      "image/svg+xml" = [
        "org.inkscape.Inkscape.desktop"
        "inkscape.desktop"
        "org.gnome.gedit.desktop"
        "eog.desktop"
      ];
      "image/tiff" = [ "eog.desktop" ];
      "image/vnd.microsoft.icon" = [ "gimp.desktop" ];
      "image/vnd.wap.wbmp" = [ "eog.desktop" ];
      "image/webp" = [ "eog.desktop" "gimp.desktop" ];
      "image/x-bmp" = [ "eog.desktop" ];
      "image/x-gray" = [ "eog.desktop" ];
      "image/x-icb" = [ "eog.desktop" ];
      "image/x-icns" = [ "eog.desktop" ];
      "image/x-ico" = [ "eog.desktop" ];
      "image/x-pcx" = [ "eog.desktop" ];
      "image/x-png" = [ "eog.desktop" ];
      "image/x-portable-anymap" = [ "eog.desktop" ];
      "image/x-portable-bitmap" = [ "eog.desktop" ];
      "image/x-portable-graymap" = [ "eog.desktop" ];
      "image/x-portable-pixmap" = [ "eog.desktop" ];
      "image/x-xbitmap" = [ "eog.desktop" ];
      "image/x-xpixmap" = [ "eog.desktop" ];
      "message/rfc822" = [ "org.gnome.gedit.desktop" ];
      "text/css" = [ "org.gnome.gedit.desktop" ];
      "text/csv" = [ "calc.desktop" "org.gnome.gedit.desktop" ];
      "text/html" = [ "org.gnome.gedit.desktop" "firefox.desktop" ];
      "text/markdown" = [ "org.gnome.gedit.desktop" ];
      "text/plain" = [
        "org.gnome.gedit.desktop"
        "calc.desktop"
        "okularApplication_txt.desktop"
        "evince.desktop"
        "atom.desktop"
        "org.kde.kdenlive.desktop"
      ];
      "text/x-tex" = [ "org.gnome.gedit.desktop" "inkscape.desktop" ];
      "video/mp4" = [ "org.gnome.Totem.desktop" "mpv.desktop" ];
      "video/quicktime" = [ "mpv.desktop" ];
      "video/webm" = [ "org.gnome.Totem.desktop" "mpv.desktop" ];
      "video/x-flv" = [
        "mpv.desktop"
        "org.gnome.Totem.desktop"
        "org.kde.kdenlive.desktop"
        "audacity.desktop"
      ];
      "video/x-matroska" = [ "mpv.desktop" ];
      "video/x-ms-wmv" = [ "mpv.desktop" ];
      "video/x-msvideo" = [ "mpv.desktop" ];
      "x-scheme-handler/chrome" = [ "firefox.desktop" ];
      "x-scheme-handler/ftp" = [ "firefox.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
      "x-scheme-handler/magnet" = [ "userapp-transmission-gtk-IWJ40Y.desktop" ];
    };
  };
}
