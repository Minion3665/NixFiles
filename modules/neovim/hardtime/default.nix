{pkgs, ...}: {
  programs.neovim = {
    plugins = [pkgs.vim-hardtime];
    extraConfig = builtins.readFile ./hardtime.vim;
  };
}

