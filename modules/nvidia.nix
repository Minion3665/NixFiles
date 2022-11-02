{ pkgs, ... }:
let
  prime-run = pkgs.writeScriptBin "prime-run" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in
{
  config = {
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware = {
      opengl.enable = true;
      nvidia = {
        modesetting.enable = true;
        prime = {
          offload.enable = true;
          intelBusId = "PCI:0:2:0";
          nvidiaBusId = "PCI:1:0:0";
        };
      };
    };
    internal.allowUnfree = [ "nvidia-x11" "nvidia-settings" "cudatoolkit" ];
  };
  home.home.packages = [ pkgs.nvtop prime-run ];
}
