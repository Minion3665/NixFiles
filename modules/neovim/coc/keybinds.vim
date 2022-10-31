nmap <silent> ]c :call CocAction('diagnosticNext')<cr>
nmap <silent> [c :call CocAction('diagnosticPrevious')<cr>
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
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
inoremap <silent><expr> <Tab> coc#pum#visible() ? coc#pum#next(0) :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackSpace() ? "\<TAB>" :
      \ coc#refresh()

function! CheckBackSpace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
inoremap <silent><expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(0) : "\<S-Tab>"
xnoremap <silent> <Tab> <Plug>(coc-snippets-select)


snoremap <nowait><silent> <Tab> <Esc>:call UltiSnips#JumpForwards()<cr>
snoremap <nowait><silent> <S-Tab> <Esc>:call UltiSnips#JumpForwards()<cr>
inoremap <silent><silent> <C-s> <Esc>l:Snippets<cr>


function! s:show_documentation()
if (index(['vim','help'], &filetype) >= 0)
execute 'h '.expand('<cword>')
else
call CocAction('doHover')
endif
endfunction

nnoremap <silent> K :call <SID>show_documentation()<CR>
