{pkgs, ...}: {
  programs.neovim = {
    plugins = [pkgs.vimPlugins.vim-hardtime];
    extraConfig = builtins.readFile ./hardtime.vim;
  };
}
