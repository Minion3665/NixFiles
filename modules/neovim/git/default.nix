{pkgs, lib, ...}: {
  programs.neovim = {
    extraConfig = ''
      source ${./git-conflict.lua}
    '' + lib.pipe [
      ./lazygit.vim
    ] [
      (map builtins.readFile)
      (builtins.concatStringsSep "\n")
    ];
    plugins = with pkgs.vimPlugins; [
      vim-gitgutter
      vim-fugitive
      lazygit-nvim
      pkgs.git-conflict-nvim
    ];
  };
}
