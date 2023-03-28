{ pkgs, ... }: {
  programs.tmux = {
    enable = true;

    shell = "${pkgs.fish}/bin/fish";

    # Start numbering tabs at 1, not 0
    baseIndex = 1;

    # Automatically spawn a session if trying to attach and none are running
    newSession = true;

    prefix = "C-a";

    extraConfig = pkgs.lib.strings.concatStringsSep "\n\n" [

      # Use shift-left and shift-right to move between tabs
      ''
        bind-key -n S-Left prev
        bind-key -n S-Right next
      ''

      # Shortcuts to move between split panes, using Control and arrow keys
      ''
        bind-key -n C-Down select-pane -D
        bind-key -n C-Up select-pane -U
        bind-key -n C-Left select-pane -L
        bind-key -n C-Right select-pane -R
      ''

      # Shortcuts to split the window into multiple panes
      #
      # Mnemonic: the symbol (- or |) looks like the line dividing the
      # two panes after the split.
      ''
        bind | split-window -h
        bind - split-window -v
      ''

      # Shortcuts to resize the currently-focused pane.
      # You can tap these repeatedly in rapid succession to adjust
      # the size incrementally (the -r flag accomplishes this).
      ''
        bind -r J resize-pane -D 5
        bind -r K resize-pane -U 5
        bind -r H resize-pane -L 5
        bind -r L resize-pane -R 5
      ''

    ];
  };
}
