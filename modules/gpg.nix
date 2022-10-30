{
  pkgs,
  username,
  ...
}: let
    pinentry-multiplexed = pkgs.writeScriptBin "pinentry" ''
        #if [[ $- == *i* ]]
        #then
            exec ${pkgs.pinentry.curses}/bin/pinentry "$@"
        #else
        #    exec ${pkgs.pinentry.gnome3}/bin/pinentry "$@"
        #fi
    '';
in {
  home = {
    programs.gpg.enable = true;
    services.gpg-agent = {
      enable = true;
      pinentryFlavor = "curses";
    };
  };

  config.environment.persistence."/nix/persist".users.${username}.directories = [
    {
      directory = ".gnupg";
      mode = "0700";
    }
  ];

  home.home.packages = [
    pinentry-multiplexed
  ];
}
