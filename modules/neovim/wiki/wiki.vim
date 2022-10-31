let g:wiki_root = '~/Documents/wiki'
let g:wiki_filetypes = ['md']
let g:wiki_link_extension = '.md'
let g:wiki_index_name = 'README'


let g:wiki_map_create_page = 'WikiCreateTransform'
function WikiCreateTransform(name) abort
  let l:name = wiki#get_root() . '/' . a:name
  let g:lastWikiOriginalName = substitute(a:name, "\.private$", "", "")
  " If the file is new, then append the current date
  return filereadable(l:name)
        \ ? a:name
        \ : a:name =~ ".*\.private$"
        \ ? substitute(g:lastWikiOriginalName, " ", "_", "g") . "_" . strftime("%Y%m%d") . ".private"
        \ : substitute(g:lastWikiOriginalName, " ", "_", "g") . '_' . strftime('%Y%m%d')
endfunction


function! TemplateFallback(context)
  call append(0, ['# ' . g:lastWikiOriginalName, ''])
endfunction

let g:wiki_templates = [
      \ { 'match_func': {x -> v:true},
      \   'source_func': function('TemplateFallback')},
      \]

nnoremap <silent> <Leader>wf :WikiFzfPages<CR>
