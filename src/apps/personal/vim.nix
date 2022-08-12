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
        let mapleader = ","
        let g:VM_leader = "\\"
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
        set ignorecase
        set smartcase
        set nocompatible
        set hidden
        set encoding=utf-8
        set scrolloff=5
        colorscheme onehalfdark

        command W w
        command Wq wq

        fun! SetupCommandAlias(from, to)
        exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
        endfun

        call SetupCommandAlias("git","Git")

        let g:camelcasemotion_key = '<leader>'

        if exists('+termguicolors')
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
        set termguicolors
        endif

        let g:better_whitespace_enabled=1
        let g:strip_whitespace_on_save=1
        let g:strip_only_modified_lines=1
        let g:strip_whitelines_at_eof=1
        let g:show_spaces_that_precede_tabs=1
        nnoremap ]w :NextTrailingWhitespace<CR>
        nnoremap [w :PrevTrailingWhitespace<CR>

        let g:airline#extensions#tabline#enabled = 1
        let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
        let g:airline_powerline_fonts = 1
        let g:airline#extensions#hunks#coc_git = 1
        let g:airline#extensions#whitespace#enabled = 1

        let g:airline#extensions#tabline#buffer_idx_mode = 1
        nmap <leader>1 <Plug>AirlineSelectTab1
        nmap <leader>2 <Plug>AirlineSelectTab2
        nmap <leader>3 <Plug>AirlineSelectTab3
        nmap <leader>4 <Plug>AirlineSelectTab4
        nmap <leader>5 <Plug>AirlineSelectTab5
        nmap <leader>6 <Plug>AirlineSelectTab6
        nmap <leader>7 <Plug>AirlineSelectTab7
        nmap <leader>8 <Plug>AirlineSelectTab8
        nmap <leader>9 <Plug>AirlineSelectTab9
        nmap <leader>0 <Plug>AirlineSelectTab0
        nmap <leader>- <Plug>AirlineSelectPrevTab
        nmap <leader>+ <Plug>AirlineSelectNextTab
        let airline#extensions#tabline#middle_click_preserves_windows = 1
        let g:airline_skip_empty_sections = 1

        let g:ctrlp_map = '<c-p>'
        let g:ctrlp_cmd = 'CtrlP'

        nmap <silent> ]c :call CocAction('diagnosticNext')<cr>
        nmap <silent> [c :call CocAction('diagnosticPrevious')<cr>
        nmap <silent> <Leader>fs <Plug>(coc-codeaction-selected)
        nmap <silent> <Leader>fg <Plug>(coc-codeaction-cursor)
        nmap <silent> <Leader>ff <Plug>(coc-codeaction)
        nmap <Leader>fe <Cmd>CocCommand explorer<CR>

        vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

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

        let g:VM_theme_set_by_colorscheme = 1
        highlight VM_Extend ctermfg=NONE guifg=NONE    ctermbg=239 guibg=#474e5d
        highlight VM_Cursor ctermfg=188  guifg=#dcdfe4 ctermbg=168 guibg=#e06c75
        highlight VM_Insert ctermfg=236  guifg=#282c34 ctermbg=176 guibg=#c678dd
        highlight VM_Mono   ctermfg=236  guifg=#282c34 ctermbg=75  guibg=#61afef

        highlight Pmenu      ctermfg=188 guifg=#dcdfe4 ctermbg=239 guibg=#474e5d
        highlight PmenuSel   ctermfg=236 guifg=#282c34 ctermbg=75  guibg=#61afef
        highlight PmenuSbar  ctermfg=237 guifg=#313640 ctermbg=237 guibg=#313640
        highlight PmenuThumb ctermfg=188 guifg=#dcdfe4 ctermbg=188 guibg=#dcdfe4

        highlight CocErrorSign   ctermfg=168 guifg=#e06c75 ctermbg=NONE guibg=NONE
        highlight CocInfoSign    ctermfg=75  guifg=#61afef ctermbg=NONE guibg=NONE
        highlight CocWarningSign ctermfg=180 guifg=#e5c07b ctermbg=NONE guibg=NONE

        nnoremap <silent> K :call <SID>show_documentation()<CR>

        autocmd BufWritePre * Neoformat

        let g:neoformat_try_node_exe = 1

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
            rainbow = {
                enable = true,
                extended_mode = true,
                max_file_lines = nil,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "gnn",
                    node_incremental = "grn",
                    scope_incremental = "grc",
                    node_decremental = "grm",
                },
            },
            indent = {
                enable = true,
            },
        }

        require('git-conflict').setup()
        EOF

        set foldmethod=expr
        set foldexpr=nvim_treesitter#foldexpr()

        set viewoptions-=options
        autocmd BufWinLeave ?* mkview!
        autocmd BufWinEnter ?* normal zR

        function! s:loadViewOrUnfold()
        try
        loadview
        catch
        folddoclosed foldopen
        endtry
        endfunction

        autocmd BufWinEnter ?* call s:loadViewOrUnfold()


        :let g:airline_highlighting_cache = 1
        autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
        '';

        plugins = [
            pkgs.vimPlugins.git-conflict-nvim
            pkgs.vimPlugins.vim-nix
            pkgs.vimPlugins.copilot-vim
            pkgs.vimPlugins.coc-tsserver
            pkgs.vimPlugins.coc-eslint
            pkgs.vimPlugins.coc-rust-analyzer
            pkgs.vimPlugins.coc-spell-checker
            pkgs.vimPlugins.coc-json
            pkgs.vimPlugins.coc-jest
            pkgs.vimPlugins.coc-css
            pkgs.vimPlugins.coc-explorer
            pkgs.vimPlugins.coc-git
            pkgs.vimPlugins.neoformat
            pkgs.vimPlugins.zoomwintab-vim
            pkgs.vimPlugins.onehalf
            pkgs.vimPlugins.neorg
            pkgs.vimPlugins.orgmode
            pkgs.vimPlugins.vim-sleuth
            pkgs.vimPlugins.vim-visual-multi
            pkgs.vimPlugins.vim-better-whitespace
            pkgs.vimPlugins.nvim-ts-rainbow
            pkgs.vimPlugins.editorconfig-nvim
            pkgs.vimPlugins.camelcasemotion
            pkgs.vimPlugins.fugitive
            pkgs.vimPlugins.vim-flog
            pkgs.vimPlugins.airline
            pkgs.vimPlugins.vista-vim
            pkgs.vimPlugins.vim-gitgutter
            pkgs.vimPlugins.ctrlp-vim
            pkgs.vimPlugins.vim-airline-clock
            pkgs.vimPlugins.vim-airline-themes
            (pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))
        ];
    };

    home.packages = [
        pkgs.universal-ctags
    ];

    home.sessionVariables.EDITOR = "${pkgs.neovim}/bin/nvim";
}
