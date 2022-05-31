{ ... }: {
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.modesetting.enable = true;

  hardware.opengl.enable = true;

  ## Not yet finished; see https://nixos.wiki/wiki/Nvidia
  # TODO: Complete this
}
