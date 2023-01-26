local kopts = {noremap = true, silent = true}

vim.api.nvim_set_keymap('n', 'n',
    [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
    kopts)
vim.api.nvim_set_keymap('n', 'N',
    [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
    kopts)
vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

vim.api.nvim_set_keymap('n', '<Leader>l', ':noh<CR>', kopts)

require("scrollbar").setup({
  handle = {
    color = vim.g["lightgrey"].gui,
  },
  marks = {
    Search = { color = vim.g["yellow"].gui },
    Error = { color = vim.g["red"].gui },
    Warn = { color = vim.g["red"].gui },
    Info = { color = vim.g["blue"].gui },
    Hint = { color = vim.g["cyan"].gui },
    Misc = { color = vim.g["purple"].gui },
  },
  handlers = {
    search = true,
  },
})
