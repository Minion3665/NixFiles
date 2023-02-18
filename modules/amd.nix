{ pkgs, ... }: {
  config = {
    boot.initrd.kernelModules = [ "radeon" "amdgpu" ];
    services.xserver.videoDrivers = [ "radeon" "amdgpu" "modesetting" "fbdev" ];
    systemd.tmpfiles.rules = [
      "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.hip}"
    ];
    hardware.opengl.driSupport = true;
    hardware.opengl.driSupport32Bit = true;
    services.hardware.bolt.enable = true;
  };
}
