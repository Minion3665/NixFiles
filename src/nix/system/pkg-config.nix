{ pkgs, ... }: {
  environment.systemPackages = [
    pkgs.pkg-config
  ];

  environment.variables.PKG_CONFIG_PATH = builtins.concatStringsSep ":" [
    "${pkgs.openssl.dev}/lib/pkgconfig"
  ];
}
