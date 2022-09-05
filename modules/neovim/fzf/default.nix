{ pkgs, ... }:{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      fzf-vim
      coc-fzf
    ];
    extraPackages = [pkgs.fzf];
  };
}
