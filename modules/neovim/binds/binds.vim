set whichwrap=b,s,<,>,[,]
set mouse=a

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
    if !isdirectory(a:dir)
          \   && (a:force
          \       || input("'" . a:dir . "' does not exist. Create? [y/N]") =~? '^y\%[es]$')
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

function! s:loadViewOrUnfold()
  try
    loadview
  catch
    folddoclosed foldopen
  endtry
endfunction

autocmd BufWinEnter ?* call s:loadViewOrUnfold()

tnoremap <Esc><Esc> <C-\><C-n>
