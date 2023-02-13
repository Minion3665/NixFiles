{ pkgs, options, lib, ... }: {
  config = {
    services.logind.extraConfig = ''
      HandlePowerKey=Ignore
      LidSwitchIgnoreInhibited=no
    '';
    boot = {
      kernelParams = [ "acpi_backlight=video" ];
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
        "hid_sensor_hub"
      ];
    };
  };

  traces = [ "config.boot.kernelModules" "config.boot.loader.systemd-boot.editor" ];
}
