{ pkgs, ... }: {
    home.file.".config/nvim/autoload/airline/themes/onehalf.vim".text = ''
    let g:airline#themes#onehalf#palette = {}
    function! airline#themes#onehalf#refresh()

    " guifg guibg ctermfg ctermbg
    let s:black       = { "gui": "#282c34", "cterm": "236" }
    let s:red         = { "gui": "#e06c75", "cterm": "168" }
    let s:green       = { "gui": "#98c379", "cterm": "114" }
    let s:yellow      = { "gui": "#e5c07b", "cterm": "180" }
    let s:blue        = { "gui": "#61afef", "cterm": "75"  }
    let s:purple      = { "gui": "#c678dd", "cterm": "176" }
    let s:cyan        = { "gui": "#56b6c2", "cterm": "73"  }
    let s:white       = { "gui": "#dcdfe4", "cterm": "188" }
    let s:statusline  = { "gui": "#313640", "cterm": "237" }
    let s:lightgrey   = { "gui": "#474e5d", "cterm": "237" }

    function! s:generateAirlinePalette(primary)
    return {
        \ 'airline_a'      : [s:black.gui, a:primary.gui, s:black.cterm, a:primary.cterm],
        \ 'airline_b'      : [s:white.gui, s:lightgrey.gui, s:white.cterm, s:lightgrey.cterm],
        \ 'airline_c'      : [a:primary.gui, s:statusline.gui, a:primary.cterm, s:statusline.cterm],
        \ 'airline_x'      : [a:primary.gui, s:statusline.gui, a:primary.cterm, s:statusline.cterm],
        \ 'airline_y'      : [s:white.gui, s:lightgrey.gui, s:white.cterm, s:lightgrey.cterm],
        \ 'airline_z'      : [s:black.gui, a:primary.gui, s:black.cterm, a:primary.cterm],
        \ 'airline_warning': [s:black.gui, s:yellow.gui, s:black.cterm, s:yellow.cterm],
        \ 'airline_error'  : [s:black.gui, s:red.gui, s:black.cterm, s:red.cterm]}
    endfunction

    let g:airline#themes#onehalf#palette.normal      = s:generateAirlinePalette(s:green)
    let g:airline#themes#onehalf#palette.visual      = s:generateAirlinePalette(s:purple)
    let g:airline#themes#onehalf#palette.select      = s:generateAirlinePalette(s:purple)
    let g:airline#themes#onehalf#palette.multi       = s:generateAirlinePalette(s:purple)
    let g:airline#themes#onehalf#palette.insert      = s:generateAirlinePalette(s:blue)
    let g:airline#themes#onehalf#palette.commandline = s:generateAirlinePalette(s:red)
    let g:airline#themes#onehalf#palette.terminal    = s:generateAirlinePalette(s:cyan)
    let g:airline#themes#onehalf#palette.replace     = s:generateAirlinePalette(s:yellow)
    let g:airline#themes#onehalf#palette.ctrlp       = s:generateAirlinePalette(s:white)
    let g:airline#themes#onehalf#palette.inactive    = s:generateAirlinePalette(s:lightgrey)
    let g:airline#themes#onehalf#palette.normal_modified      = s:generateAirlinePalette(s:green)
    let g:airline#themes#onehalf#palette.visual_modified      = s:generateAirlinePalette(s:purple)
    let g:airline#themes#onehalf#palette.select_modified      = s:generateAirlinePalette(s:purple)
    let g:airline#themes#onehalf#palette.multi_modified       = s:generateAirlinePalette(s:purple)
    let g:airline#themes#onehalf#palette.insert_modified      = s:generateAirlinePalette(s:blue)
    let g:airline#themes#onehalf#palette.commandline_modified = s:generateAirlinePalette(s:red)
    let g:airline#themes#onehalf#palette.terminal_modified    = s:generateAirlinePalette(s:cyan)
    let g:airline#themes#onehalf#palette.replace_modified     = s:generateAirlinePalette(s:yellow)
    let g:airline#themes#onehalf#palette.ctrlp_modified       = s:generateAirlinePalette(s:white)
    endfunction

    call airline#themes#onehalf#refresh()
    '';
    programs.neovim = {
        enable = true;
        coc = {
            enable = true;
            settings = {
                "suggest.noselect" = false;
                "cSpell.checkOnlyEnabledFileTypes" = false;
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
        set signcolumn=yes
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


        let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

        let g:VM_mouse_mappings = 1
        nnoremap <silent> <leader>gg :LazyGit<CR>

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


        let g:airline_highlighting_cache = 1
        let g:airline_theme = "onehalf"
        autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
        '';

        plugins = with pkgs.vimPlugins; [
            git-conflict-nvim
            vim-nix
            copilot-vim
            coc-tsserver
            coc-eslint
            coc-rust-analyzer
            coc-spell-checker
            coc-json
            coc-jest
            coc-css
            coc-explorer
            coc-git
            neoformat
            zoomwintab-vim
            onehalf
            neorg
            orgmode
            vim-sleuth
            vim-visual-multi
            vim-better-whitespace
            nvim-ts-rainbow
            editorconfig-nvim
            camelcasemotion
            fugitive
            vim-flog
            airline
            vista-vim
            vim-gitgutter
            ctrlp-vim
            vim-airline-clock
            lazygit-nvim
            (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))
        ];
    };

    home.packages = with pkgs; [
        universal-ctags
        nodePackages.cspell
    ];

    home.sessionVariables.EDITOR = "${pkgs.neovim}/bin/nvim";
}
