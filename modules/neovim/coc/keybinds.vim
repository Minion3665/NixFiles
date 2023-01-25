nmap <silent> ]c :silent! call CocAction('diagnosticNext')<cr>
nmap <silent> [c :silent! call CocAction('diagnosticPrevious')<cr>
nmap <silent> <Leader>fs <Plug>(coc-codeaction-selected)
nmap <silent> <Leader>fb <Plug>(coc-codeaction)
nmap <silent> <Leader>ff <Plug>(coc-codeaction-cursor)
nmap <silent> <Leader>fc <Plug>(coc-codeaction-cursor)
nmap <silent> <Leader>fr <Plug>(coc-rename)
nmap <silent> <Leader>fi <Plug>(coc-fix-current)
nmap <silent> <Leader>gd <Plug>(coc-definition)zz
nmap <silent> <Leader>gt <Plug>(coc-type-definition)
nmap <silent> <Leader>gi <Plug>(coc-implementation)zz
nmap <silent> <Leader>gr <Plug>(coc-references)
nmap <Leader>fe <Cmd>CocCommand explorer<CR>

let g:UltiSnipsExpandTrigger="<NUL>"
let g:UltiSnipsJumpForwardTrigger="<NUL>"
let g:UltiSnipsJumpBackwardTrigger="<NUL>"

inoremap <silent><expr> <CR> coc#pum#visible() ? "\<C-G>u" . coc#pum#confirm() :
      \ coc#jumpable() ? "\<Esc>:call coc#snippet#next()\<CR>" :
      \ tablemode#table#IsTable('.') && !(tablemode#spreadsheet#GetLastRow(".") == line('.')) && !(tablemode#spreadsheet#GetLastRow(".") == 0) ? "\<Esc>:call tablemode#spreadsheet#cell#Motion('j')\<CR>:call tablemode#spreadsheet#MoveToStartOfCell()\<CR>" . mode() :
      \ tablemode#table#IsTable('.') ? "<Esc>$a<CR>" :
      \ "\<C-G>u\<Plug>(PearTreeExpand)"

inoremap <silent><expr> <S-CR> tablemode#table#IsTable('.') ? "\<Esc>:call tablemode#spreadsheet#cell#Motion('k')\<CR>:call tablemode#spreadsheet#MoveToStartOfCell()\<CR>" . mode() : "\<S-CR>"

let g:codeium_no_map_tab = 1
let g:codeium_tab_fallback = ""
inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(0) :
      \ coc#expandableOrJumpable() ? "\<C-G>u\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ codeium#Accept() != "" ? "\<C-G>u" . codeium#Accept() :
      \ pear_tree#GetSurroundingPair() != [] ? pear_tree#insert_mode#JumpOut() : 
      \ tablemode#table#IsTable('.') ? "\<Esc>:call tablemode#spreadsheet#cell#Motion('l')\<CR>" . mode() :
      \ CheckBackSpace() ? "\<TAB>" : coc#refresh()

function! CheckBackSpace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(0) : 
      \ coc#jumpable() ? "\<Esc>:call coc#snippet#prev()\<CR>" :
      \ tablemode#table#IsTable('.') ? "\<Esc>:call tablemode#spreadsheet#cell#Motion('h')\<CR>" . mode() :
      \ "\<Plug>(PearTreeJump)"
xnoremap <silent> <Tab> <Plug>(coc-snippets-select)

nnoremap <silent><expr> <CR> coc#jumpable() ?
      \ ":call coc#snippet#next()\<CR>" :
      \ tablemode#table#IsTable('.') ? "\<Esc>:call tablemode#spreadsheet#cell#Motion('j')\<CR>:call tablemode#spreadsheet#MoveToStartOfCell()\<CR>" :
      \ "\<C-G>u\<CR>"

nnoremap <silent><expr> <S-CR> tablemode#table#IsTable('.') ? "\<Esc>:call tablemode#spreadsheet#cell#Motion('k')\<CR>:call tablemode#spreadsheet#MoveToStartOfCell()\<CR>" : "\<S-CR>"

nnoremap <silent><expr> <Tab> coc#jumpable() ?
      \ ":call coc#snippet#next()\<CR>" :
      \ pear_tree#GetSurroundingPair() != [] ? pear_tree#insert_mode#JumpOut() :
      \ tablemode#table#IsTable('.') ? "\<Esc>:call tablemode#spreadsheet#cell#Motion('l')\<CR>" :
      \ "\<Tab>"

nnoremap <silent><expr> <S-Tab> coc#jumpable() ?
      \ ":call coc#snippet#prev()\<CR>" :
      \ tablemode#table#IsTable('.') ? "\<Esc>:call tablemode#spreadsheet#cell#Motion('h')\<CR>" :
      \ "\<S-Tab>"

snoremap <silent><expr> <CR> coc#jumpable() ?
      \ "\<Esc>:call coc#snippet#next()\<CR>" :
      \ "\<C-G>u\<CR>"

snoremap <silent><expr> <Tab> coc#jumpable() ?
      \ "\<Esc>:call coc#snippet#next()\<CR>" :
      \ (pear_tree#GetSurroundingPair() != [] ? pear_tree#insert_mode#JumpOut() : "\<Tab>")

snoremap <silent><expr> <S-Tab> coc#jumpable() ?
      \ "\<Esc>:call coc#snippet#prev()\<CR>" :
      \ "\<S-Tab>"

noremap <C-CR> <CR>

inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<C-f>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<C-b>"

function! s:show_documentation()
if (index(['vim','help'], &filetype) >= 0)
execute 'h '.expand('<cword>')
else
call CocAction('doHover')
endif
endfunction

nnoremap <silent> K :call <SID>show_documentation()<CR>

command Snippets CocFzfList snippets
