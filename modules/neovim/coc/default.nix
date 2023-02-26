{ pkgs
, system
, lib
, nixpkgs-minion
, home
, utils
, omnisharp-language-server
, ...
}: {
  programs.neovim = {
    coc = {
      enable = true;
      settings = {
        diagnostic.floatConfig = {
          border = true;
          rounded = true;
        };
        signature.floatConfig = {
          border = true;
          rounded = true;
        };
        hover.floatConfig = {
          border = true;
          rounded = true;
        };
        suggest.floatConfig = {
          border = true;
          rounded = true;
        };
        "suggest.noselect" = true;
        "cSpell.checkOnlyEnabledfileTypes" = false;
        "diagnostic.virtualText" = true;
        "diagnostic.virtualTextCurrentLineOnly" = false;
        "suggest.virtualText" = true;
        "cSpell.dictionaryDefinitions" = [
          {
            name = "imperative";
            path = "${home.home.homeDirectory}/.local/share/cspell/dictionary.txt";
          }
        ];
        "cSpell.dictionaries" = [ "imperative" ];
        "git.enableGutters" = false; # We're using another plugin to do this
        "rust-analyzer.server.path" = "${pkgs.rust-analyzer}/bin/rust-analyzer";
        "omnisharp.path" = "${pkgs.omnisharp-roslyn}/bin/OmniSharp";
        "markdownlint.config" = {
          line-length = {
            code_blocks = false;
            tables = false;
          };
          MD024.siblings_only = true;
          MD037 = false;
        };
        languageserver = {
          nix = {
            command = "${pkgs.rnix-lsp}/bin/rnix-lsp";
            filetypes = [ "nix" ];
          };
          haskell = {
            command = "${pkgs.haskell-language-server}/bin/haskell-language-server-wrapper";
            args = [ "--lsp" ];
            rootPatterns = [
              "*.cabal"
              "stack.yaml"
              "cabal.project"
              "package.yaml"
              "hie.yaml"
            ];
            filetypes = [ "haskell" "lhaskell" ];
            settings = {
              haskell = {
                checkParents = "CheckOnSave";
                checkProject = true;
                maxCompletions = 40;
                formattingProvider = "ormolu";
                plugin = {
                  stan = { globalOn = true; };
                };
              };
            };
          };
          ccls = {
            command = "${pkgs.ccls}/bin/ccls";
            filetypes = [ "c" "cc" "cpp" "c++" "objc" "objcpp" "C" ];
            rootPatterns = [ ".ccls" "compile_commands.json" ".git/" ".vim/" ];
            initializationOptions.cache.directory = "/tmp/ccls";
          };
        };
        "snippets.extends" = {
          markdown = [ "tex" ];
        };
        "snippets.autoTrigger" = false;
        "codeLens.enable" = true;
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
      coc-pyright
      coc-java

      # Spellchecker
      coc-spell-checker
      nixpkgs-minion.legacyPackages.${system}.vimPlugins.coc-omnisharp

      # File explorer
      coc-explorer
      coc-git # TODO: Check if coc-git is still needed

      # Snippet completion
      vim-snippets
      coc-snippets
    ];
    extraConfig = lib.pipe [ ./keybinds.vim ./theme.vim ] [
      (map builtins.readFile)
      (builtins.concatStringsSep "\n")
    ];
    extraPackages = with pkgs; [
      nodejs
      rustc
      go
      rust-analyzer
      stylish-haskell
      haskell-language-server
      (haskellPackages.ghcWithPackages (pkgs: with pkgs; [
        dbus
        monad-logger
        xmonad-contrib
      ]))
      texlab
      omnisharp-roslyn
      jdt-language-server
      jdk
      nodePackages.pyright
      (python3.withPackages (pyPkgs:
        with pyPkgs; [
          pycodestyle
          black
          rope
        ]))
      libclang
      ccls
    ];
  };
  home.file =
    lib.pipe ./snippets [
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
      /* lib.traceValSeq */
    ]
    // {
      ".config/coc/placeholder".text = "";
    };
}
