set tabstop=2
set shiftwidth=0

exec "highlight IndentBlanklineContextChar ctermfg=" . g:white.cterm . " guifg=" . g:white.gui . " ctermbg=NONE guibg=NONE"
exec "highlight IndentBlanklineContextStart ctermfg=NONE guifg=NONE guisp=white ctermbg=NONE guibg=NONE gui=underline term=underline"
exec "highlight IndentBlanklineIndent1 ctermfg=" . g:darkred.cterm . " guifg=" . g:darkred.gui . " ctermbg=NONE guibg=NONE"
exec "highlight IndentBlanklineIndent2 ctermfg=" . g:darkyellow.cterm . " guifg=" . g:darkyellow.gui . " ctermbg=NONE guibg=NONE"
exec "highlight IndentBlanklineIndent3 ctermfg=" . g:darkgreen.cterm . " guifg=" . g:darkgreen.gui . " ctermbg=NONE guibg=NONE"
exec "highlight IndentBlanklineIndent4 ctermfg=" . g:darkcyan.cterm . " guifg=" . g:darkcyan.gui . " ctermbg=NONE guibg=NONE"
exec "highlight IndentBlanklineIndent5 ctermfg=" . g:darkblue.cterm . " guifg=" . g:darkblue.gui . " ctermbg=NONE guibg=NONE"
exec "highlight IndentBlanklineIndent6 ctermfg=" . g:darkpurple.cterm . " guifg=" . g:darkpurple.gui . " ctermbg=NONE guibg=NONE"
