{
  pkgs,
  lib,
  ...
}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      (nvim-treesitter.withPlugins (plugins:
        (builtins.attrValues plugins)
        ++ (with pkgs.vimPlugins; [
          nvim-ts-rainbow
          nvim-treesitter-refactor
        ])))
      nvim-treesitter-context
    ];
    extraConfig = ''
      source ${./setup.lua}
    '';
  };
}
