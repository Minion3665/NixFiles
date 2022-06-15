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
    '';
    plugins = [
      pkgs.vimPlugins.vim-nix
    ];
  };

  home.sessionVariables.EDITOR = "${pkgs.neovim}/bin/nvim";
}
