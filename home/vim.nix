{ pkgs, ... }: {
  programs.vim = {
    enable = true;
    settings = {
      ignorecase = true;
      smartcase = true;
      shiftwidth = 2;
      tabstop = 2;
    };
    extraConfig = pkgs.lib.strings.concatStringsSep "\n\n" [
      "set lbr"

      # Rename : to ; so you can type it more easily without shift
      "nnoremap ; :"

      # Aliases for common typos
      ''
        command Wq wq
        command WQ wq
        command Q q
      ''

      ''
        function! s:Saving_scroll(cmd)
            let save_scroll = &scroll
            execute 'normal! ' . a:cmd
            let &scroll = save_scroll
        endfunction
        nnoremap <C-J> :call <SID>Saving_scroll("1<C-V><C-D>")<CR>
        vnoremap <C-J> <Esc>:call <SID>Saving_scroll("gv1<C-V><C-D>")<CR>
        nnoremap <C-K> :call <SID>Saving_scroll("1<C-V><C-U>")<CR>
        vnoremap <C-K> <Esc>:call <SID>Saving_scroll("gv1<C-V><C-U>")<CR>
      ''

      # enable syntax highlighting
      "syntax on"

      # insert spaces instead of tabs
      "set expandtab"

      # enable automatic indentation
      "set autoindent"

      "set backspace=indent,eol,start"

      # keystrokes which may wrap around lines:
      #   b          backspace
      #   s          space
      #   <,>,h,l    arrow keys
      #   [,]        arrow keys in insert mode
      "set whichwrap=b,s,<,>,h,l,[,]"

      # when truncating the last line in a window, display @
      # symbols at the end of the line, instead of one per line
      "set display=lastline"

      # show line numbers
      "set number"

      # turn on search highlighting
      "set hls"

      # save (^\ exits visual mode)
      "inoremap <F12> <Space><BS><C-><C-O>:update<CR>"

      "set incsearch"

      "filetype on"

      "filetype plugin on"

      "set ttymouse=xterm2"
    ];
  };
}
