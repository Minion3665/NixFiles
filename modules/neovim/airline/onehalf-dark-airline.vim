let g:airline#themes#onehalf#palette = {}
    function! airline#themes#onehalf#refresh()

    function! s:generateAirlinePalette(primary)
    return {
        \ 'airline_a'      : [g:black.gui, a:primary.gui, g:black.cterm, a:primary.cterm],
        \ 'airline_b'      : [g:white.gui, g:lightgrey.gui, g:white.cterm, g:lightgrey.cterm],
        \ 'airline_c'      : [a:primary.gui, g:statusline.gui, a:primary.cterm, g:statusline.cterm],
        \ 'airline_x'      : [a:primary.gui, g:statusline.gui, a:primary.cterm, g:statusline.cterm],
        \ 'airline_y'      : [g:white.gui, g:lightgrey.gui, g:white.cterm, g:lightgrey.cterm],
        \ 'airline_z'      : [g:black.gui, a:primary.gui, g:black.cterm, a:primary.cterm],
        \ 'airline_warning': [g:black.gui, g:yellow.gui, g:black.cterm, g:yellow.cterm],
        \ 'airline_error'  : [g:black.gui, g:red.gui, g:black.cterm, g:red.cterm]}
    endfunction

    let g:airline#themes#onehalf#palette.normal      = s:generateAirlinePalette(g:green)
    let g:airline#themes#onehalf#palette.visual      = s:generateAirlinePalette(g:purple)
    let g:airline#themes#onehalf#palette.select      = s:generateAirlinePalette(g:purple)
    let g:airline#themes#onehalf#palette.multi       = s:generateAirlinePalette(g:purple)
    let g:airline#themes#onehalf#palette.insert      = s:generateAirlinePalette(g:yellow)
    let g:airline#themes#onehalf#palette.commandline = s:generateAirlinePalette(g:red)
    let g:airline#themes#onehalf#palette.terminal    = s:generateAirlinePalette(g:cyan)
    let g:airline#themes#onehalf#palette.replace     = s:generateAirlinePalette(g:blue)
    let g:airline#themes#onehalf#palette.inactive    = s:generateAirlinePalette(g:white)
    let g:airline#themes#onehalf#palette.normal_modified      = s:generateAirlinePalette(g:green)
    let g:airline#themes#onehalf#palette.visual_modified      = s:generateAirlinePalette(g:purple)
    let g:airline#themes#onehalf#palette.select_modified      = s:generateAirlinePalette(g:purple)
    let g:airline#themes#onehalf#palette.multi_modified       = s:generateAirlinePalette(g:purple)
    let g:airline#themes#onehalf#palette.insert_modified      = s:generateAirlinePalette(g:yellow)
    let g:airline#themes#onehalf#palette.commandline_modified = s:generateAirlinePalette(g:red)
    let g:airline#themes#onehalf#palette.terminal_modified    = s:generateAirlinePalette(g:cyan)
    let g:airline#themes#onehalf#palette.replace_modified     = s:generateAirlinePalette(g:blue)


    let g:airline#themes#onehalf#palette.tabline = {
        \ 'airline_tabtype' : [g:white.gui, g:lightgrey.gui, g:white.cterm, g:lightgrey.cterm]}

    endfunction

    call airline#themes#onehalf#refresh()
