{ pkgs, lanzaboote, lib, ... }: {
  imports = [
    lanzaboote.nixosModules.lanzaboote
  ];
  config = {
    boot = {
      bootspec.enable = true;
      loader.systemd-boot.enable = lib.mkForce false;
      lanzaboote = {
        enable = true;
        pkiBundle = "/etc/secureboot";
      };
    };

    environment = {
      persistence."/nix/persist".directories = [
        "/etc/secureboot"
      ];
      systemPackages = [ pkgs.sbctl ];
    };
  };
}
