{ username, ... }: {
  config = {
    services.openssh.enable = true;

    environment.persistence."/nix/persist" = {
      directories = [
        "/etc/ssh"
      ];
      users.${username}.directories = [ ".ssh" ];
    };
  };

  home = {
    programs.ssh = {
      enable = true;
      matchBlocks = {
        logerrit = {
          hostname = "gerrit.libreoffice.org";
          identityFile = "~/.ssh/id_rsa";
          port = 29418;
          user = "Minion3665";
        };
        transplace = {
          hostname = "95.217.87.112";
          identityFile = "~/.ssh/id_transplace";
        };
        tildetown = {
          hostname = "tilde.town";
          user = "minion";
          identityFile = "~/.ssh/id_tildetown";
        };
        clicks = {
          hostname = "clicksminuteper.asuscomm.com";
          port = 5122;
          user = "minion";
          identityFile = "~/.ssh/clicks_rsa";
        };
        "sshtron.zachlatta.com" = {
          hostname = "sshtron.zachlatta.com";
          extraOptions = {
            PubkeyAcceptedAlgorithms = "+ssh-rsa";
            HostkeyAlgorithms = "+ssh-rsa";
          };
        };
      };
    };

    home.shellAliases = {
      ssh = "kitty +kitten ssh";
    };
  };
}
