{ ... }: {
  programs.neovim = {
    enable = true;
    coc.enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
