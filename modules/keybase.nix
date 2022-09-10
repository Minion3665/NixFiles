{
  pkgs,
  config,
  username,
  ...
}: {
  home.home.packages = [pkgs.keybase-gui];
  config = {
    services.keybase.enable = true;
    environment.persistence."/nix/persist".users.${username}.directories = [
      ".config/keybase"
    ];
  };
}
