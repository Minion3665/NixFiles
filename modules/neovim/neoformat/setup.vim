" autocmd BufWritePre * undojoin | try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry

let g:shfmt_opt="-ci"
let g:neoformat_try_node_exe = 1

let g:neoformat_enabled_javascript = ["prettier-eslint", "eslint_d", "prettier"]
let g:neoformat_enabled_typescript = ["prettier-eslint", "eslint_d", "prettier"]
