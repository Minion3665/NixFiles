{ pkgs, ... }: {
  programs.neovim = {
    plugins = [ pkgs.vimPlugins.vim-hexokinase ];
    extraConfig = ''
      let g:Hexokinase_highlighters = ['virtual']
    '';
  };
}
