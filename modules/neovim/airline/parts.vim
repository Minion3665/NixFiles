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
" TODO: Check if this is actually used with airline

let g:airline#extensions#hunks#coc_git = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#whitespace#checks = ['indent', 'trailing', 'mixed-indent-file', 'conflicts']
let g:airline#extensions#whitespace#skip_indent_check_ft =
  \ {'markdown': ['trailing']}

let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_skip_empty_sections = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 2
