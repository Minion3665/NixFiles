{ pkgs, ... }: {
  programs.neovim = {
    plugins = [ pkgs.vimPlugins.wilder-nvim ];
    extraConfig = builtins.readFile ./wilder.vim;
  };
}
