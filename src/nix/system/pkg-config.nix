{ pkgs, ... }: {
  environment.systemPackages = [
    pkgs.pkg-config
  ];
}
