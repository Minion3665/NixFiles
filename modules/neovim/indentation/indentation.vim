set tabstop=2
set shiftwidth=0

call g:Highlight("IndentBlanklineContextChar", g:white, g:transparent)
autocmd ColorScheme onehalfdark exec "highlight IndentBlanklineContextStart ctermfg=NONE guifg=NONE guisp=white ctermbg=NONE guibg=NONE gui=underline term=underline"
call g:Highlight("IndentBlanklineIndent1", g:darkred, g:transparent)
call g:Highlight("IndentBlanklineIndent2", g:darkyellow, g:transparent)
call g:Highlight("IndentBlanklineIndent3", g:darkgreen, g:transparent)
call g:Highlight("IndentBlanklineIndent4", g:darkcyan, g:transparent)
call g:Highlight("IndentBlanklineIndent5", g:darkblue, g:transparent)
call g:Highlight("IndentBlanklineIndent6", g:darkpurple, g:transparent)
