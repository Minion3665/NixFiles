{pkgs, ...}: {
  programs.neovim = {
    extraConfig =
      builtins.readFile ./indentation.vim
      + ''
        source ${./indentation.lua}
      '';
    plugins = with pkgs.vimPlugins; [
      vim-sleuth
      indent-blankline-nvim
    ];
  };
}
