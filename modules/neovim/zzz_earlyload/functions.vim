fun! g:SetupCommandAlias(from, to)
    exec 'cnoreabbrev <expr> '.a:from
    \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
    \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun

function g:Highlight(group, fg, bg)
  exec ("autocmd ColorScheme onehalfdark highlight! " . a:group . " ctermfg=" . a:fg.cterm . " ctermbg=" . a:bg.cterm . " guifg=" . a:fg.gui . " guibg=" . a:bg.gui)
endfunction

