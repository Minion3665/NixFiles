{ pkgs, ... }: {
  programs.neovim = {
    plugins = [
      pkgs.vimPlugins.vim-mundo
    ];
    extraConfig = builtins.readFile ./undo.vim;
  };
}
