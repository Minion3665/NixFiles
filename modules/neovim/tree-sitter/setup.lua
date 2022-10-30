require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {'org'},
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
    colors = {
      "#e06c75",
      "#e5c07b",
      "#98c379",
      "#56b6c2",
      "#61afef",
      "#c678dd",
    },
    termcolors = {
      "168",
      "180",
      "114",
      "73",
      "75",
      "176",
    },
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true,
  },
}

require('treesitter-context').setup{
  enable = true,
  trim_scope = 'outer',
  patterns = {
    default = {
      'class',
      'function',
      'method',
      'for',
      'while',
      'if',
      'switch',
      'case',
    },
  },
  mode = 'topline'
}

vim.cmd[[hi! TreesitterContext guibg=#313640 ctermbg=237]]
