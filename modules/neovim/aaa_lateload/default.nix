{
  programs.neovim.extraConfig = ''
    ${builtins.readFile ./retheme.vim} 
  '';
}
