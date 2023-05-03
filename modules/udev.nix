{ pkgs, ... }: {
  config.services.udev.packages = [
    (pkgs.stdenv.mkDerivation {
      pname = "udev-rules";
      version = "2023-03-18";

      src = ./udev/rules;

      installPhase = ''
        mkdir -p $out/etc/udev/rules.d/
        cp $src/* $out/etc/udev/rules.d/
      '';
    })
  ];
}
