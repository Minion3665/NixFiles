{pkgs, ...}: {
  programs.neovim = {
    plugins = [pkgs.wiki-vim];
    extraConfig = builtins.readFile ./wiki.vim;
    extraPackages = with pkgs; [pandoc texlive.combined.scheme-medium];
  };
}
