{ pkgs, options, lib, ... }: {
  config = {
    boot = {
      loader = {
        systemd-boot = {
          /* enable = true; */ # Replaced by secure-boot.nix
          editor = false;
        };
        efi.canTouchEfiVariables = true;
      };
      kernelPackages = pkgs.linuxPackages_zen;
      blacklistedKernelModules = [
        "bridge"
        "loop"
        "macvlan"
        "msr"
        "nf_nat_ftp"
        "razercore"
        "razerfirefly"
        "razerkbd"
        "razerkraken"
        "razermouse"
        "razermug"
        "tap"
        "tun"
        "veth"
      ];
    };
  };

  traces = [ "config.boot.kernelModules" "config.boot.loader.systemd-boot.editor" ];
}
