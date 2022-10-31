{pkgs, ...}: {
  programs.neovim = {
    plugins = [pkgs.vimPlugins.pear-tree];
    extraConfig = builtins.readFile ./pear-tree.vim;
  };
}
