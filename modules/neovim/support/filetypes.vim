augroup docx
autocmd!
  autocmd BufReadPre *.docx silent set ro
  autocmd BufEnter *.docx silent set modifiable
  autocmd BufEnter *.docx silent %!pandoc -f docx -t markdown --wrap=preserve "%"
augroup END
