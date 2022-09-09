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
