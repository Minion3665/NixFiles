{ pkgs, ... }: {
  programs.neovim = {
    plugins = [ pkgs.vimPlugins.suda-vim ];

    extraConfig = builtins.readFile ./suda.vim;
  };
}
