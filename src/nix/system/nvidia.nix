{ pkgs, ... }: {
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.modesetting.enable = true;

  hardware.opengl.enable = true;

  environment.systemPackages = [
    pkgs.egl-wayland
  ];

  ## Not yet finished; see https://nixos.wiki/wiki/Nvidia
  # TODO: Complete this
}
