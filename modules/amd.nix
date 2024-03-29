{ pkgs, lib, ... }: {
  home = {
    home.file.".config/prelaunch/amd-output-source.sh".text = ''
      if [[ $(xrandr --listproviders | grep "AMD Radeon RX 6700 XT @ pci:0000:06:00.0") ]]; then
        xrandr --setprovideroutputsource "AMD Radeon RX 6700 XT @ pci:0000:06:00.0" modesetting
      fi
    '';
    home.file.".config/prelaunch/amd-output-source.sh".executable = true;
  };
  config = {
    boot.initrd.kernelModules = [ "amdgpu" ];
    services.xserver.videoDrivers = [ "modesetting" "fbdev" ];
    /* services.xserver.defaultDepth = 24; */
    systemd.tmpfiles.rules = [
      "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.hip}"
    ];
    hardware.opengl.driSupport = true;
    hardware.opengl.driSupport32Bit = true;
    services.hardware.bolt.enable = true;
    /* services.xserver.config = lib.mkAfter '' */
    /*   Section "Device" */
    /*     Identifier "Device-radeon[1]" */
    /*     Driver     "radeon" */
    /*     BusID      "PCI:06:00.0" */
    /*     Option     "AllowExternalGpus" "True" */
    /*     Option     "AllowEmptyInitialConfiguration" */
    /*     # Option     "TearFree" "true" */
    /*   EndSection */
    /* ''; */
  };
}
