{ pkgs, ... }: {
  home.packages = [
    pkgs.exa
  ];

  programs.zsh.initExtra = ''
  function ls {
      if [ -t 1 ] ; then
        ${pkgs.exa}/bin/exa --icons -lghF --git --group-directories-first --color always "$@" | less --quit-if-one-screen
      else
        ${pkgs.coreutils}/bin/ls "$@"
      fi
    }
  '';

  home.shellAliases = {
    ls = "ls";  # Unset the default ls alias
  };
}
