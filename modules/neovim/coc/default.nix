{
  pkgs,
  system,
  lib,
  nixpkgs-minion,
  home,
  utils,
  omnisharp-language-server,
  ...
}: {
  programs.neovim = {
    coc = {
      enable = true;
      settings = {
        suggest.floatConfig = {
          border = true;
          rounded = true;
        };
        "suggest.noselect" = false;
        "cSpell.checkOnlyEnabledfileTypes" = false;
        "diagnostic.virtualText" = true;
        "diagnostic.virtualTextCurrentLineOnly" = false;
        "cSpell.dictionaryDefinitions" = [
          {
            name = "imperative";
            path = "${home.home.homeDirectory}/.local/share/cspell/dictionary.txt";
          }
        ];
        "cSpell.dictionaries" = ["imperative"];
        "git.enableGutters" = false; # We're using another plugin to do this
        "rust-analyzer.server.path" = "${pkgs.rust-analyzer}/bin/rust-analyzer";
        "omnisharp.path" = "${pkgs.omnisharp-roslyn}/bin/OmniSharp";
        "markdownlint.config" = {
          line-length = {
            code_blocks = false;
            tables = false;
          };
        };
        languageserver = {
          nix = {
            command = "${pkgs.rnix-lsp}/bin/rnix-lsp";
            filetypes = ["nix"];
          };
        };
      };
    };
    plugins = with pkgs.vimPlugins; [
      # Language servers
      coc-tsserver
      coc-eslint
      coc-rust-analyzer
      coc-json
      coc-jest
      coc-css
      coc-go
      coc-markdownlint
      coc-texlab

      # Spellchecker
      nixpkgs-minion.legacyPackages.${system}.vimPlugins.coc-spell-checker
      nixpkgs-minion.legacyPackages.${system}.vimPlugins.coc-omnisharp

      # File explorer
      coc-explorer
      coc-git # TODO: Check if coc-git is still needed

      # Snippet completion
      vim-snippets
      coc-snippets

      # General utils
      coc-pairs
    ];
    extraConfig = lib.pipe [./keybinds.vim ./theme.vim] [
      (map builtins.readFile)
      (builtins.concatStringsSep "\n")
    ];
    extraPackages = with pkgs; [
      nodejs
      rustc
      go
      rust-analyzer
      texlab
      omnisharp-roslyn
    ];
  };
  home.file = lib.pipe ./snippets [
    builtins.readDir
    builtins.attrNames
    (map
      (f: {
        name = ".config/nvim/UltiSnips/${f}";
        value = {
          source = ./snippets + "/${f}";
          target = ".config/nvim/UltiSnips/${f}";
        };
      }))
    builtins.listToAttrs
    lib.traceValSeq
  ] // {
    ".config/coc/placeholder".text = "";
  };
}
