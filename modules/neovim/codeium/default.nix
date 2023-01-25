{ pkgs, ... }: {
  programs.neovim.plugins = [ pkgs.codeium-vim ];
}
