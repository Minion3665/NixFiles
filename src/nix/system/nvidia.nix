{ pkgs, ... }: {
  # services.xserver.videoDrivers = [ "noveau" ];
  # hardware.nvidia.modesetting.enable = true;

  # hardware.opengl.enable = true;

  # environment.systemPackages = [
  #   pkgs.egl-wayland
  # ];

  # environment.etc."/egl/egl_external_platform.d/nvidia_wayland.json".text = ''
  #   "file_format_version" : "1.0.0",
  #   "ICD": {
  #     "library_path" : "/run/opengl-driver/lib/libnvidia-egl-wayland.so"
  #   }
  # '';

  ## Not yet finished; see https://nixos.wiki/wiki/Nvidia
  # TODO: Complete this
}
