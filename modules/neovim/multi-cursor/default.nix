{pkgs, ...}: {
  programs.neovim = {
    plugins = [pkgs.vimPlugins.vim-visual-multi];
    extraConfig = builtins.readFile ./theme.vim;
  };
}
