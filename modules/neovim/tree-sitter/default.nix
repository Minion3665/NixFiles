{ pkgs
, lib
, nixpkgs-minion
, system
, ...
}:
let
  disabledGrammars = [
    "tree-sitter-sql"
  ];
in
{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      (nvim-treesitter.withPlugins (plugins:
        (lib.pipe plugins [
          (lib.filterAttrs (name: value: !builtins.elem name disabledGrammars))
          builtins.attrValues
        ])
        ++ (with pkgs.vimPlugins; [
          nvim-ts-rainbow
          nixpkgs-minion.legacyPackages.${system}.tree-sitter-grammars.tree-sitter-astro
        ])))
      nvim-treesitter-context
    ];
    extraConfig = ''
      source ${./setup.lua}
    '';
  };
}
