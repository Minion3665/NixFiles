let g:wiki_root = '~/Documents/wiki'
let g:wiki_filetypes = ['md']
let g:wiki_link_extension = '.md'


let g:wiki_map_create_page = 'WikiCreateTransform'
function WikiCreateTransform(name) abort
  let l:name = wiki#get_root() . '/' . a:name
  " If the file is new, then append the current date
  return filereadable(l:name)
        \ ? a:name
        \ : substitute(a:name, " ", "_", "g") . '_' . strftime('%Y%m%d')
endfunction

nnoremap <silent> <Leader>wf :WikiFzfPages<CR>
