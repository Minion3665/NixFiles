{
  pkgs,
  lib,
  ...
}: let
  disabledGrammars = [
    "tree-sitter-sql"
  ];
in {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      (nvim-treesitter.withPlugins (plugins:
        (lib.pipe plugins [
          (lib.filterAttrs (name: value: !builtins.elem name disabledGrammars))
          builtins.attrValues
        ])
        ++ (with pkgs.vimPlugins; [
          nvim-ts-rainbow
        ])))
      nvim-treesitter-context
    ];
    extraConfig = ''
      source ${./setup.lua}
    '';
  };
}
