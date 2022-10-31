call g:Highlight("DiagnosticInfo", g:blue, g:transparent)
call g:Highlight("DiagnosticHint", g:blue, g:transparent)
call g:Highlight("DiagnosticWarn", g:yellow, g:transparent)
call g:Highlight("DiagnosticError", g:red, g:transparent)

highlight DiagnosticUnderlineError guisp=#e06c75
highlight DiagnosticUnderlineInfo  guisp=#61afef
highlight DiagnosticUnderlineHint  guisp=#61afef
highlight DiagnosticUnderlineWarn  guisp=#e5c07b

call g:Highlight("CocPumMenu", g:transparent, g:black)
call g:Highlight("CocFloating", g:transparent, g:black)
call g:Highlight("CocSearch", g:red, g:transparent)
