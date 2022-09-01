{
  pkgs,
  lib,
  ...
}: {
  programs.neovim = {
    coc = {
      enable = true;
      settings = {
        "suggest.noselect" = false;
        "cSpell.checkOnlyEnabledfileTypes" = false;
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

      # Spellchecker
      coc-spell-checker # FIXME: Broken in upstream, needs an overlay

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
    extraPackages = [pkgs.nodejs pkgs.rustc];
  };
}