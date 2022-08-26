if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
colorscheme onehalfdark

highlight Pmenu  ctermfg=188 guifg=#dcdfe4 ctermbg=239 guibg=#474e5d
highlight PmenuSel   ctermfg=236 guifg=#282c34 ctermbg=75  guibg=#61afef
highlight PmenuSbar  ctermfg=237 guifg=#313640 ctermbg=237 guibg=#313640
highlight PmenuThumb ctermfg=188 guifg=#dcdfe4 ctermbg=188 guibg=#dcdfe4

set signcolumn=yes
set guicursor=v-r-cr:hor50,i:ver50
set splitright
set splitbelow
set scrolloff=3
set number

" guifg guibg ctermfg ctermbg
let g:black       = { "gui": "#282c34", "cterm": "236" }
let g:red         = { "gui": "#e06c75", "cterm": "168" }
let g:green       = { "gui": "#98c379", "cterm": "114" }
let g:yellow      = { "gui": "#e5c07b", "cterm": "180" }
let g:blue        = { "gui": "#61afef", "cterm": "75"  }
let g:purple      = { "gui": "#c678dd", "cterm": "176" }
let g:cyan        = { "gui": "#56b6c2", "cterm": "73"  }
let g:statusline  = { "gui": "#313640", "cterm": "237" }
let g:lightgrey   = { "gui": "#474e5d", "cterm": "237" }
let g:darkred     = { "gui": "#844C55", "cterm": "167" }
let g:darkyellow  = { "gui": "#877658", "cterm": "136" }
let g:darkgreen   = { "gui": "#607857", "cterm": "71"  }
let g:darkcyan    = { "gui": "#3F717B", "cterm": "31"  }
let g:darkblue    = { "gui": "#456E92", "cterm": "31"  }
let g:darkpurple  = { "gui": "#775289", "cterm": "127" }
let g:white       = { "gui": "#dcdfe4", "cterm": "188" }

