if !exists('g:vscode')
  call wilder#setup({'modes': [':', '/', '?']})

  call wilder#set_option('pipeline', [
        \   wilder#branch(
        \     wilder#cmdline_pipeline({
        \       'fuzzy': 1,
        \       'set_pcre2_pattern': 1,
        \     }),
        \     wilder#python_search_pipeline({
        \       'pattern': 'fuzzy',
        \     }),
        \   ),
        \ ])

  let s:highlighters = [
          \ wilder#pcre2_highlighter(),
          \ wilder#basic_highlighter(),
          \ ]

  call wilder#set_option('renderer', wilder#renderer_mux({
        \ ':': wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
        \   'highlighter': s:highlighters,
        \   'highlights': {
        \     'border': 'Normal',
        \     'default': 'Normal',
        \     'selected': wilder#make_hl('WilderSelected', 'Normal', [{}, {}, {'background': g:lightgrey.gui}]),
        \     'accent': wilder#make_hl('WilderAccent', 'Normal', [{}, {}, {'foreground': g:red.gui}]),
        \     'selected_accent': wilder#make_hl('WilderSelectedAccent', 'WilderSelected', [{}, {}, {'foreground': g:red.gui}]),
        \   },
        \   'border': 'rounded',
        \ })),
        \ '/': wilder#wildmenu_airline_theme({
        \   'highlighter': s:highlighters,
        \ }),
        \ '?': wilder#wildmenu_airline_theme({
        \   'highlighter': s:highlighters,
        \ }),
        \ }))
endif
