{ pkgs, ... }: {
  programs.neovim = {
    plugins = [ pkgs.vimPlugins.presence-nvim ];

    extraConfig = builtins.readFile ./presence.vim;
  };
}
