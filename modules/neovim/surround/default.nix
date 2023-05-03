{ pkgs, ... }: {
  programs.neovim = {
    plugins = [ pkgs.vimPlugins.nvim-surround ];

    extraConfig = "source ${./surround.lua}";
  };
}
