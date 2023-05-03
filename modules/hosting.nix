{ pkgs, username, ... }: {
  home.home.packages = [
    pkgs.mysql
    pkgs.pscale # Planetscale cli
  ];
  config.environment.persistence."/large/persist".users.${username}.directories = [
    ".config/planetscale"
  ];
}
