{ pkgs
, username
, prismlauncher
, ...
}: {
  home.home.packages = [ prismlauncher.legacyPackages.x86_64-linux.prismlauncher ];
  config.environment.persistence."/large/persist".users.${username}.directories = [ ".local/share/PrismLauncher" ];
}
