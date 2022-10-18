{
  pkgs,
  username,
  ...
}: {
  home.home.packages = [];
  config.environment.persistence."/large/persist".users.${username}.directories = [".local/share/PolyMC"];
}
