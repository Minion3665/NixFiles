if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
colorscheme onehalfdark

call g:Highlight("PmenuSbar", g:statusline, g:statusline)
call g:Highlight("PmenuThumb", g:white, g:white)
call g:Highlight("PmenuSel", g:transparent, g:lightgrey)
call g:Highlight("Pmenu", g:transparent, g:statusline)

call g:Highlight("HlSearchLens", g:darkyellow, g:transparent)
call g:Highlight("HlSearchLensNear", g:white, g:darkyellow)

set signcolumn=yes
set guicursor=v-r-cr:hor50,i:ver50
set guifont=Liga\ Roboto\ Mono:h12
set splitright
set splitbelow
set scrolloff=3
set number

set textwidth=80
set colorcolumn=+1
call g:Highlight("ColorColumn", g:transparent, g:statusline)

set number

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

