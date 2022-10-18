{ pkgs, ... }: {
  config.environment.systemPackages = [
    pkgs.pkg-config
  ];
}
