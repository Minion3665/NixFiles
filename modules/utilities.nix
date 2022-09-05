{pkgs, ...}: {
  # Basic shell scripting utilities, they don't deserve their own file but I use
  # them
  config.environment.systemPackages = with pkgs; [
    jq
    bc
    (sd.overrideAttrs (oldAttrs: {
      postInstall = ''
        mv $out/bin/sd $out/bin/s
      '';
    }))
    lnav
  ];

  home = {
    programs = {
      exa.enable = true;
      bat.enable = true;
      zsh.initExtra = ''
      function ls {
        if [ -t 1 ] ; then
          ${pkgs.exa}/bin/exa --icons -lghF --git --group-directories-first --color always "$@" | less --quit-if-one-screen
        else
          ${pkgs.coreutils}/bin/ls "$@"
        fi
      }
      unalias ls
      '';
    };
    home.shellAliases = {
      cat = "${pkgs.bat}/bin/bat --wrap never --pager \"less -+S\"";
    };
  };
}
