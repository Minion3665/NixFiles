set whichwrap=b,s,<,>,[,]
set mouse=

vmap <C-k> :m-2<CR>
vmap <C-j> :m+1<CR>
nmap <C-k> :m-2<CR>
nmap <C-j> :m+1<CR>

vmap <F12> <Esc>
imap <F12> <Esc>
nmap <F12> <Esc>
tmap <F12> <C-C>
cmap <F12> <Esc>
omap <F12> <Esc>
smap <F12> <Esc>

vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

fun! SetupCommandAlias(from, to)
    exec 'cnoreabbrev <expr> '.a:from
    \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
    \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun

augroup vimrc-auto-mkdir
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
  function! s:auto_mkdir(dir, force)
    if !isdirectory(a:dir) && !(a:dir =~ "^suda:///.*$")
          \   && (a:force
          \       || input("'" . a:dir . "' does not exist. Create? [y/N]: ") =~? '^y\%[es]$')
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction
augroup END
" https://stackoverflow.com/a/42872275/12293760

augroup vimrc-auto-neoformat
  autocmd!
  autocmd BufWritePre * call s:auto_neoformat(v:cmdbang)
  function! s:auto_neoformat(force)
    if a:force
      Neoformat
    endif
  endfunction
augroup END

command W w
command Wq wq
call SetupCommandAlias("git","Git")
call SetupCommandAlias("rg","Rg")

set ignorecase
set smartcase

set expandtab

let g:cursorhold_updatetime = 1000
autocmd CursorHoldI,CursorHold,BufLeave ?* silent! update

set viewoptions-=options
autocmd BufWinLeave ?* silent! mkview!

set nofoldenable
autocmd BufWinEnter ?* silent! loadview

tnoremap <Esc><Esc> <C-\><C-n>

let g:camelcasemotion_key = '<leader>m'
