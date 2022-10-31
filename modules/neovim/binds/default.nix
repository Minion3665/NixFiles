{ pkgs, ... }: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [ FixCursorHold-nvim camelcasemotion ];
    extraConfig = builtins.readFile ./binds.vim;
  };
}
