augroup docx
autocmd!
  autocmd BufReadPre *.docx silent set ro
  autocmd BufEnter *.docx silent set modifiable 
  autocmd BufEnter *.docx silent %!pandoc -f docx -t markdown --wrap=preserve "%"
  autocmd BufEnter *.docx silent set filetype=markdown
  autocmd BufEnter *.docx silent set nomodifiable
augroup END
