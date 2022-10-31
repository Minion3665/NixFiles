autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete

if has('nvim')
  let $GIT_EDITOR = 'nvr -cc split --remote-wait'
  let $EDITOR = 'nvr'
endif
