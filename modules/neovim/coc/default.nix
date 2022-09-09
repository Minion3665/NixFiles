{
  pkgs,
  system,
  lib,
  nixpkgs-minion,
  home,
  ...
}: {
  programs.neovim = {
    coc = {
      enable = true;
      settings = {
        "suggest.noselect" = false;
        "cSpell.checkOnlyEnabledfileTypes" = false;
        "cSpell.dictionaryDefinitions" = [
          {
            name = "imperative";
            path = "${home.home.homeDirectory}/.local/share/cspell/dictionary.txt";
          }
        ];
        "cSpell.dictionaries" = ["imperative"];
        "git.enableGutters" = false; # We're using another plugin to do this
        "rust-analyzer.serverPath" = "${pkgs.rust-analyzer}/bin/rust-analyzer";
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

      # Spellchecker
      nixpkgs-minion.legacyPackages.${system}.vimPlugins.coc-spell-checker

      # File explorer
      coc-explorer
      coc-git # TODO: Check if coc-git is still needed

      # Snippet completion
      coc-snippets
      vim-snippets
    ];
    extraConfig = lib.pipe [./keybinds.vim ./theme.vim] [
      (map builtins.readFile)
      (builtins.concatStringsSep "\n")
    ];
    extraPackages = [pkgs.nodejs pkgs.rustc pkgs.go];
  };
}
