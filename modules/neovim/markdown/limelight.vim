autocmd User GoyoEnter Limelight
autocmd User GoyoLeave Limelight!

function s:loadListChars()
  if exists("b:savedListChars")
    let &listchars = g:savedListChars
  endif
endfunction

function s:saveListchars()
  let g:savedListChars = &listchars
  let &listchars=""
endfunction

autocmd User GoyoLeave call s:loadListChars()
autocmd User GoyoEnter call s:saveListchars()

let g:limelight_conceal_ctermfg = g:lightgrey.cterm
let g:limelight_conceal_guifg = g:lightgrey.gui
let g:limelight_paragraph_span = 1
let g:limelight_priority = -1
