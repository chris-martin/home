{
  programs.darcs = {
    enable = true;
    author = [ "Chris Martin <ch.martin@gmail.com>" ];
    boring = [ "^.idea$" ".iml$" "^.stack-work$" ];
  };
}
