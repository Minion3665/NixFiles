set whichwrap=b,s,<,>,[,]
set mouse=a

vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

fun! SetupCommandAlias(from, to)
    exec 'cnoreabbrev <expr> '.a:from
    \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
    \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun

command W w
command Wq wq
call SetupCommandAlias("git","Git")

set ignorecase
set smartcase

set expandtab
