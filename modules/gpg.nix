{ pkgs
, username
, lib
, ...
}: {
  home = {
    programs.gpg.enable = true;
    services.gpg-agent = {
      enable = true;
      extraConfig = ''
        pinentry-program ${pkgs.pinentry-rofi}/bin/pinentry-rofi
      '';
    };
    systemd.user.sockets.gpg-agent.Install.WantedBy = lib.mkForce [ ];
  };

  config.environment.persistence."/nix/persist".users.${username}.directories = [
    {
      directory = ".gnupg";
      mode = "0700";
    }
  ];

  home.home.packages = [
    pkgs.pinentry-rofi
  ];
}
