{ pkgs, ... }: {
  programs.neovim = {
    plugins = [ pkgs.vimPlugins.FixCursorHold-nvim ];
    extraConfig = builtins.readFile ./binds.vim;
  };
}
