nmap <silent> ]c :silent! call CocAction('diagnosticNext')<cr>
nmap <silent> [c :silent! call CocAction('diagnosticPrevious')<cr>
nmap <silent> <Leader>fs <Plug>(coc-codeaction-selected)
nmap <silent> <Leader>fb <Plug>(coc-codeaction)
nmap <silent> <Leader>ff <Plug>(coc-codeaction-cursor)
nmap <silent> <Leader>fc <Plug>(coc-codeaction-cursor)
nmap <silent> <Leader>fr <Plug>(coc-rename)
nmap <silent> <Leader>fi <Plug>(coc-fix-current)
nmap <Leader>fe <Cmd>CocCommand explorer<CR>

let g:UltiSnipsExpandTrigger="<NUL>"
let g:UltiSnipsJumpForwardTrigger="<NUL>"
let g:UltiSnipsJumpBackwardTrigger="<NUL>"
inoremap <silent><expr> <CR> coc#pum#visible() ? "\<C-g>u" . coc#pum#confirm() :
      \ coc#jumpable() ? "\<C-g>u<Esc>:call coc#snippet#next()\<CR>" :
      \ "\<Plug>(PearTreeExpand)"
inoremap <silent><expr> <Tab> coc#pum#visible() ? coc#pum#next(0) :
      \ coc#expandableOrJumpable() ? "\<C-g>u\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ (pear_tree#GetSurroundingPair() != [] ? pear_tree#insert_mode#JumpOut() : (CheckBackSpace() ? "\<TAB>" :
      \ coc#refresh()))

function! CheckBackSpace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(0) : 
      \ coc#jumpable() ? "\<C-g>u<Esc>:call coc#snippet#prev()\<CR>" :
      \ "\<S-Tab>"
xnoremap <silent> <Tab> <Plug>(coc-snippets-select)

nnoremap <silent><expr> <CR> coc#jumpable() ?
      \ ":call coc#snippet#next()\<CR>" :
      \ "\<CR>"

nnoremap <silent><expr> <Tab> coc#jumpable() ?
      \ ":call coc#snippet#next()\<CR>" :
      \ (pear_tree#GetSurroundingPair() != [] ? pear_tree#insert_mode#JumpOut() : "\<Tab>")

nnoremap <silent><expr> <S-Tab> coc#jumpable() ?
      \ ":call coc#snippet#prev()\<CR>" :
      \ "\<S-Tab>"

snoremap <silent><expr> <CR> coc#jumpable() ?
      \ "\<C-g>u<Esc>:call coc#snippet#next()\<CR>" :
      \ "\<CR>"

snoremap <silent><expr> <Tab> coc#jumpable() ?
      \ "\<C-g>u<Esc>:call coc#snippet#next()\<CR>" :
      \ (pear_tree#GetSurroundingPair() != [] ? pear_tree#insert_mode#JumpOut() : "\<Tab>")

snoremap <silent><expr> <S-Tab> coc#jumpable() ?
      \ "\<C-g>u<Esc>:call coc#snippet#prev()\<CR>" :
      \ "\<S-Tab>"

function! s:show_documentation()
if (index(['vim','help'], &filetype) >= 0)
execute 'h '.expand('<cword>')
else
call CocAction('doHover')
endif
endfunction

nnoremap <silent> K :call <SID>show_documentation()<CR>

command Snippets CocFzfList snippets
