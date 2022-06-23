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
      set wrap
      set number
      set cursorline
      colorscheme onehalfdark

      if exists('+termguicolors')
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
        set termguicolors
      endif
    '';
    plugins = [
      pkgs.vimPlugins.vim-nix
      pkgs.vimPlugins.copilot-vim
      pkgs.vimPlugins.coc-tsserver
      pkgs.vimPlugins.zoomwintab-vim
      pkgs.vimPlugins.onehalf
    ];
  };

  home.sessionVariables.EDITOR = "${pkgs.neovim}/bin/nvim";
}
