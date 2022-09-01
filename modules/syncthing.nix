{username, ...}: {
  home.services.syncthing.enable = true;

  config.environment.persistence."/nix/persist".users.${username}.directories = ["Sync" ".config/syncthing"];
}
