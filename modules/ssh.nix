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
          hostname = "192.168.89.74";
          proxyJump = "ssh.coded.codes";
          user = "minion";
          identityFile = "~/.ssh/id_rsa";
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
      ssh = "wezterm ssh";
    };
  };
}
