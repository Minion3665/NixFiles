nmap <silent> ]c :call CocAction('diagnosticNext')<cr>
nmap <silent> [c :call CocAction('diagnosticPrevious')<cr>
nmap <silent> <Leader>fs <Plug>(coc-codeaction-selected)
nmap <silent> <Leader>fb <Plug>(coc-codeaction)
nmap <silent> <Leader>ff <Plug>(coc-codeaction-cursor)
nmap <silent> <Leader>fc <Plug>(coc-codeaction-cursor)
nmap <silent> <Leader>fr <Plug>(coc-rename)
nmap <silent> <Leader>fi <Plug>(coc-fix-current)
nmap <Leader>fe <Cmd>CocCommand explorer<CR>

function! s:show_documentation()
if (index(['vim','help'], &filetype) >= 0)
execute 'h '.expand('<cword>')
else
call CocAction('doHover')
endif
endfunction

nnoremap <silent> K :call <SID>show_documentation()<CR>
