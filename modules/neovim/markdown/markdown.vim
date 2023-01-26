set conceallevel=2
let g:vim_markdown_no_extensions_in_markdown = 1
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_autowrite = 1

let g:pandoc#filetypes#pandoc_markdown = 0
let g:pandoc#filetypes#handled = ["pandoc", "rst", "textile", "markdown"]
let g:pandoc#formatting#textwidth = 80
let g:pandoc#formatting#mode = "h"
let g:pandoc#spell#enabled = 0

let g:mkdp_auto_close = 0

autocmd FileType markdown call tablemode#Enable()

call g:SetupCommandAlias("goyo", "Goyo")
nnoremap <silent> <leader>wm :Goyo<CR>
let g:goyo_width = 83

function s:DisableTextwidthOnTable()
  if tablemode#table#IsTable(".")
    setlocal textwidth=0
  else
    let &l:textwidth=&g:textwidth
  endif
endfunction

autocmd CursorMovedI,CursorMoved,BufEnter *.md call s:DisableTextwidthOnTable()
