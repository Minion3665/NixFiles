if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
colorscheme onehalfdark

function g:Highlight(group, fg, bg)
  exec ("highlight! " . a:group . " ctermfg=" . a:fg.cterm . " ctermbg=" . a:bg.cterm . " guifg=" . a:fg.gui . " guibg=" . a:bg.gui)
endfunction

highlight Pmenu  ctermfg=188 guifg=#dcdfe4 ctermbg=239 guibg=#474e5d
highlight PmenuSel   ctermfg=236 guifg=#282c34 ctermbg=75  guibg=#61afef
highlight PmenuSbar  ctermfg=237 guifg=#313640 ctermbg=237 guibg=#313640
highlight PmenuThumb ctermfg=188 guifg=#dcdfe4 ctermbg=188 guibg=#dcdfe4

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

