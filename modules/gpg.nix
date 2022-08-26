{
  pkgs,
  username,
  ...
}: {
  home = {
    programs.gpg.enable = true;
    services.gpg-agent = {
      enable = true;
      extraConfig = ''
        pinentry-program ${pkgs.pinentry.curses}/bin/pinentry
      '';
    };
  };

  config.environment.persistence."/nix/persist".users.${username}.directories = [
    {
      directory = ".gnupg";
      mode = "0700";
    }
  ];
}
