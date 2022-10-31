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

call g:Highlight("DiagnosticVirtualTextInfo", g:darkblue, g:transparent)
call g:Highlight("DiagnosticVirtualTextHint", g:darkblue, g:transparent)
call g:Highlight("DiagnosticVirtualTextWarn", g:darkyellow, g:transparent)
call g:Highlight("DiagnosticVirtualTextError", g:darkred, g:transparent)

call g:Highlight("CocCodeLens", g:lightgrey, g:transparent)
call g:Highlight("CocPumVirtualText", g:lightgrey, g:transparent)
call g:Highlight("CocInlayHint", g:darkpurple, g:transparent)
