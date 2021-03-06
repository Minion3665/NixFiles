{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    coc = {
      enable = true;
      settings = {
        "suggest.noselect" = false;
      };
    };
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraConfig = ''
      set whichwrap=b,s,<,>,[,]
      set linebreak
      set wrap
      set number
      set cursorline
      set expandtab
      set mouse=a
      set splitright
      set splitbelow
      set clipboard=unnamedplus
      set smartcase
      colorscheme onehalfdark

      if exists('+termguicolors')
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
        set termguicolors
      endif

      highlight ExtraWhitespace ctermbg=red guibg=red
      match ExtraWhitespace /\s\+$/
      " highlight Tab ctermbg=red guibg=red
      " match Tab /\t/

      set statusline=%t       "tail of the filename
      set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
      set statusline+=%{&ff}] "file format
      set statusline+=%h      "help file flag
      set statusline+=%m      "modified flag
      set statusline+=%r      "read only flag
      set statusline+=%y      "filetype
      set statusline+=%=      "left/right separator
      set statusline+=%c,     "cursor column
      set statusline+=%l/%L   "cursor line/total lines
      set statusline+=\ %P    "percent through file

      nnoremap <silent> K :call <SID>show_documentation()<CR>

      function! s:show_documentation()
        if (index(['vim','help'], &filetype) >= 0)
          execute 'h '.expand('<cword>')
        else
          call CocAction('doHover')
        endif
      endfunction

      lua << EOF
        require('neorg').setup {
          load = {
            ["core.defaults"] = {}
          }
        }

        require('orgmode').setup_ts_grammar()

        require('nvim-treesitter.configs').setup {
          highlight = {
            enable = true,
            additional_vim_regex_highlighting = {'org'},
          },
          indent = {
            enable = true,
          },
        }

        require('git-conflict').setup()
      EOF
    '';

    plugins = [
      pkgs.vimPlugins.git-conflict-nvim
      pkgs.vimPlugins.vim-nix
      pkgs.vimPlugins.copilot-vim
      pkgs.vimPlugins.coc-tsserver
      pkgs.vimPlugins.coc-eslint
      pkgs.vimPlugins.zoomwintab-vim
      pkgs.vimPlugins.onehalf
      pkgs.vimPlugins.neorg
      pkgs.vimPlugins.orgmode
      pkgs.vimPlugins.vim-sleuth
      pkgs.vimPlugins.vim-visual-multi
      (pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins: [
        pkgs.tree-sitter-grammars.tree-sitter-go
        pkgs.tree-sitter-grammars.tree-sitter-nix
        pkgs.tree-sitter-grammars.tree-sitter-tsx
        pkgs.tree-sitter-grammars.tree-sitter-rust
        pkgs.tree-sitter-grammars.tree-sitter-css
        pkgs.tree-sitter-grammars.tree-sitter-norg
        pkgs.tree-sitter-grammars.tree-sitter-json
        pkgs.tree-sitter-grammars.tree-sitter-glsl
        pkgs.tree-sitter-grammars.tree-sitter-regex
        pkgs.tree-sitter-grammars.tree-sitter-latex
        pkgs.tree-sitter-grammars.tree-sitter-python
        pkgs.tree-sitter-grammars.tree-sitter-comment
        pkgs.tree-sitter-grammars.tree-sitter-markdown
        pkgs.tree-sitter-grammars.tree-sitter-org-nvim
        pkgs.tree-sitter-grammars.tree-sitter-typescript
        pkgs.tree-sitter-grammars.tree-sitter-javascript
      ]))
    ];
  };

  home.sessionVariables.EDITOR = "${pkgs.neovim}/bin/nvim";
}
