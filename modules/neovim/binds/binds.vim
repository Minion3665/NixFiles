set whichwrap=b,s,<,>,[,]
set mouse=

vnoremap <silent> <C-k> :m-2<CR>gv
vnoremap <silent><expr> <C-j> ":m+" . (line("'>") - line("'<") + 1) . "\<CR>gv"
nnoremap <silent> <C-k> :m-2<CR>
nnoremap <silent> <C-j> :m+1<CR>

nnoremap <C-d> <C-d>zz
nnoremap <C-b> <C-b>zz

nnoremap <C-u> <C-u>zz
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>zz:redraw!<CR>"

nnoremap N Nzz
nnoremap n nzz

vmap <F12> <Esc>
imap <F12> <Esc>
nmap <F12> <Esc>
tmap <F12> <C-C>
cmap <F12> <Esc>
omap <F12> <Esc>
smap <F12> <Esc>

vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

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

command! W w
command! Wq wq
call g:SetupCommandAlias("rg","Rg")

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

nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
nnoremap <silent> <C-d> <C-d>:redraw!<CR>

function! s:start_delete(key)
    let l:result = a:key
    if !s:deleting
        let l:result = "\<C-G>u".l:result
    endif
    let s:deleting = 1
    return l:result
endfunction

function! s:check_undo_break(char)
    if s:deleting
        let s:deleting = 0
        call feedkeys("\<BS>\<C-G>u".a:char, 'n')
    endif
endfunction

augroup smartundo
    autocmd!
    autocmd InsertEnter * let s:deleting = 0
    autocmd InsertCharPre * call s:check_undo_break(v:char)
augroup END

inoremap <expr> <BS> <SID>start_delete("\<BS>")
inoremap <expr> <C-W> <SID>start_delete("\<C-W>")
inoremap <expr> <C-U> <SID>start_delete("\<C-U>")

" Undo stuff from https://vi.stackexchange.com/a/2377/38793
