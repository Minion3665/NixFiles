call g:Highlight("TreesitterContext", g:statusline, g:transparent)

au ColorScheme onehalfdark hi! link @text.title Title

call g:Highlight("@text.literal", g:purple, g:transparent)

au ColorScheme onehalfdark hi! link @punctuation.delimiter @comment

call g:Highlight("@text.uri", g:blue, g:transparent)

au ColorScheme onehalfdark hi @text.reference cterm=italic gui=italic

au ColorScheme onehalfdark hi! link @string.escape @text.reference

call g:Highlight("@punctuation.special", g:lightgrey, g:transparent)
call g:Highlight("@punctuation.special.list", g:red, g:transparent)
call g:Highlight("@punctuation.special.header", g:lightgrey, g:transparent)
call g:Highlight("@punctuation.special.thematic_break", g:red, g:transparent)
call g:Highlight("@string.escape", g:transparent, g:lightgrey)

au ColorScheme onehalfdark hi! @text.strong cterm=bold gui=bold
au ColorScheme onehalfdark hi! @text.emphasis cterm=italic gui=italic
