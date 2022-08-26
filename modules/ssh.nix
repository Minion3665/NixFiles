{username, ...}: {
  config = {
    services.openssh.enable = true;

    environment.persistence."/nix/persist" = {
      directories = [
        "/etc/ssh"
      ];
      users.${username}.directories = [".ssh"];
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
      };
    };

    home.shellAliases = {
      ssh = "kitty +kitten ssh";
      s = "kitty +kitten ssh";
    };
  };
}
