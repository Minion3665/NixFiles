{ config, pkgs, lib, ... }: {
  virtualisation.containerd.enable = true;

  virtualisation.containerd.settings = {
    version = 2;
#    grpc = {
#      uid = 1000;
#    };
  };

  environment.systemPackages ++= with pkgs; [
    cni
    cni-plugins
  ];
}
