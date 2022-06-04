{ pkgs, ... }: {
  home.packages = [
    pkgs.exa
  ];

  home.shellAliases = {
    ls = "${pkgs.exa}/bin/exa --icons -laghF --git --group-directories-first --color always $@ | less --quit-if-one-screen";
  };
}
