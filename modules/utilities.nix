{ pkgs, ... }: {
  # Basic shell scripting utilities, they don't deserve their own file but I use
  # them
  config = {
    environment.systemPackages = with pkgs; [
      jq
      bc
      (sd.overrideAttrs (oldAttrs: {
        postInstall = ''
          mv $out/bin/sd $out/bin/s
        '';
      }))
      lnav
      dogdns
      iproute2
      fd
      procs
      grex
      btop
      rustscan
      gping
      curlie
    ];
  };

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
      dig = "${pkgs.dogdns}/bin/dog";
      ip = "${pkgs.iproute2}/bin/ip -c --brief";
      ipo = "${pkgs.iproute2}/bin/ip";
      ps = "${pkgs.procs}/bin/procs";
      htop = "${pkgs.btop}/bin/btop";
      ping = "${pkgs.gping}/bin/gping";
      pingo = "${pkgs.inetutils}/bin/ping";
      curl = "${pkgs.curlie}/bin/curlie";
      curio = "${pkgs.curl}/bin/curl";
      nix-provider = "${./utilities/nix-provider.sh}";
    };
  };
}
