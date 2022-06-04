{ pkgs, ... }: {
  home.packages = [
    pkgs.exa
  ];

  programs.zsh.initExtra = ''
    function ls {
      ${pkgs.exa}/bin/exa --icons -lghF --git --group-directories-first --color always "$@" | less --quit-if-one-screen
    }
  '';

  home.shellAliases = {
    ls = "ls";  # Unset the default ls alias
  };
}
