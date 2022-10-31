let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1
let g:pear_tree_map_special_keys = 0

autocmd FileType tex let b:pear_tree_pairs = extend(deepcopy(g:pear_tree_pairs), {
  \ '$': {'closer': '$'},
  \ }, 'keep')
autocmd FileType markdown let b:pear_tree_pairs = extend(deepcopy(g:pear_tree_pairs), {
  \ '`': {'closer': '`'},
  \ '```': {'closer': '```'},
  \ '$': {'closer': '$'},
  \ }, 'keep')

imap <BS> <Plug>(PearTreeBackspace)
imap <Esc> <Plug>(PearTreeFinishExpansion)
