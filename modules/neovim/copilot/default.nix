{ pkgs, ... }: {
  programs.neovim.plugins = [
    pkgs.vimPlugins.copilot-vim
  ];
}
