call g:Highlight("DiagnosticInfo", g:blue, g:transparent)
call g:Highlight("DiagnosticHint", g:blue, g:transparent)
call g:Highlight("DiagnosticWarn", g:yellow, g:transparent)
call g:Highlight("DiagnosticError", g:red, g:transparent)

au ColorScheme onehalfdark highlight DiagnosticUnderlineError guisp=#e06c75
au ColorScheme onehalfdark highlight DiagnosticUnderlineInfo  guisp=#61afef
au ColorScheme onehalfdark highlight DiagnosticUnderlineHint  guisp=#61afef
au ColorScheme onehalfdark highlight DiagnosticUnderlineWarn  guisp=#e5c07b

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

lua << EOF
local ok, lsp_lines = pcall(require, 'lsp_lines')
if ok then
  lsp_lines.setup()
end
-- lsp_lines can sometimes fail to load (i.e. in git commits).
-- We must not crash if it does not exist
EOF
