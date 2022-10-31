let g:wiki_root = '~/Documents/wiki'
let g:wiki_filetypes = ['md']
let g:wiki_link_extension = '.md'
let g:wiki_index_name = 'README'


let g:wiki_map_create_page = 'WikiCreateTransform'
function WikiCreateTransform(name) abort
  if wiki#get_root() != wiki#get_root_global()
    let g:lastWikiOriginalName = a:name
    return substitute(g:lastWikiOriginalName, " ", "_", "g")
  endif
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
  if exists("g:lastWikiOriginalName")
    call append(0, ['# ' . g:lastWikiOriginalName, ''])
    unlet! g:lastWikiOriginalName
  else
    call append(0, ['# ' . a:context.name, ''])
  endif
endfunction

let g:wiki_templates = [
      \ { 'match_func': {x -> v:true},
      \   'source_func': function('TemplateFallback')},
      \]

nnoremap <silent> <Leader>wf :WikiFzfPages<CR>
