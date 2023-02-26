{ pkgs, lib, username, ... }:
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
/*   config = { */
/*     services.xserver.videoDrivers = [ "nvidia" ]; */
/*     hardware = { */
/*       opengl.enable = true; */
/*       nvidia = { */
/*         modesetting.enable = true; */
/*         powerManagement.enable = true; */
/*         prime = { */
/*           offload.enable = true; */
/*           intelBusId = "PCI:0:2:0"; */
/*           nvidiaBusId = "PCI:1:0:0"; */
/*         }; */
/*       }; */
/*     }; */

/*     specialisation.nvidia-sync.configuration = { */
/*       system.nixos.tags = [ "nvidia-sync" ]; */
/*       hardware.nvidia.powerManagement.enable = lib.mkForce false; */
/*       hardware.nvidia.prime.offload.enable = lib.mkForce false; */
/*       hardware.nvidia.prime.sync.enable = lib.mkForce true; */
/*       services.xserver.dpi = 96; */

/*       home-manager.users.${username}.home.file.".xinitrc".text = lib.mkBefore '' */
/*         ${pkgs.xorg.xrandr}/bin/xrandr --setprovideroutputsource modesetting NVIDIA-0 */
/*         ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-0 --primary --mode 3840x2160 --pos 0x0 --rotate normal --output eDP-1-1 --mode 1920x1080 --pos 960x2160 --rotate normal */
/*       ''; */
/*     }; */

/*     internal.allowUnfree = [ "nvidia-x11" "nvidia-settings" "cudatoolkit" ]; */
/*   }; */
/*   home.home.packages = [ pkgs.nvtop prime-run ]; */
}
