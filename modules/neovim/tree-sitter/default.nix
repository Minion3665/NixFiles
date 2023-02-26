{ pkgs
, lib
, nixpkgs-minion
, system
, ...
}:
let
  disabledGrammars = [
    "sql"
  ];
in
{
  home.file.".config/nvim/after/queries/markdown/highlights.scm".source = ./highlights.scm;
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      (nvim-treesitter.withPlugins (plugins:
        (lib.pipe plugins [
          (lib.filterAttrs (name: value: builtins.substring 0 12 name == "tree-sitter-"))
          (lib.filterAttrs (name: value: !builtins.elem
            (builtins.substring 12 (builtins.stringLength name) name)
            disabledGrammars
          ))
          # lib.traceVal
          builtins.attrValues
        ])
        ++ (with pkgs.vimPlugins; [
          nvim-ts-rainbow
          nvim-ts-context-commentstring
          nixpkgs-minion.legacyPackages.${system}.tree-sitter-grammars.tree-sitter-astro
        ])))
      nvim-treesitter-context
      playground
    ];
    extraConfig = ''
      source ${./setup.lua}
    '' + builtins.readFile ./highlights.vim;
  };
}
