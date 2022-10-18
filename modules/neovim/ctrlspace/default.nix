{ pkgs, ... }: {
  programs.neovim = {
    plugins = [ pkgs.vim-ctrlspace ];
    extraConfig = builtins.readFile ./settings.vim;
  };
}
