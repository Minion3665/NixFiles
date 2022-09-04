{pkgs, ...}: {
  programs.neovim = {
    plugins = [pkgs.wiki-vim];
    extraConfig = builtins.readFile ./wiki.vim;
  };
}
