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
    '';
    plugins = [
      pkgs.vimPlugins.vim-nix
      pkgs.vimPlugins.copilot-vim
    ];
  };

  home.sessionVariables.EDITOR = "${pkgs.neovim}/bin/nvim";
}
