{ pkgs
, username
, ...
}: {
  home.home.packages = [ pkgs.prismlauncher ];
  config.environment.persistence."/large/persist".users.${username}.directories = [ ".local/share/PrismLauncher" ];
}
