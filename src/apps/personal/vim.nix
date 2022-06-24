{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    coc = {
      enable = true;
      settings = {
        "suggest.noselect" = false;
      };
    };
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraConfig = ''
      set whichwrap=b,s,<,>,[,]
      set linebreak
      set wrap
      set number
      set cursorline
      colorscheme onehalfdark

      if exists('+termguicolors')
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
        set termguicolors
      endif

      set statusline=%t       "tail of the filename
      set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
      set statusline+=%{&ff}] "file format
      set statusline+=%h      "help file flag
      set statusline+=%m      "modified flag
      set statusline+=%r      "read only flag
      set statusline+=%y      "filetype
      set statusline+=%=      "left/right separator
      set statusline+=%c,     "cursor column
      set statusline+=%l/%L   "cursor line/total lines
      set statusline+=\ %P    "percent through file
    '';
    plugins = [
      pkgs.vimPlugins.vim-nix
      pkgs.vimPlugins.copilot-vim
      pkgs.vimPlugins.coc-tsserver
      pkgs.vimPlugins.zoomwintab-vim
      pkgs.vimPlugins.onehalf
      pkgs.vimPlugins.neorg
    ];
  };

  home.sessionVariables.EDITOR = "${pkgs.neovim}/bin/nvim";
}
