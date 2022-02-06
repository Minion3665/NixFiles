{ pkgs, ... }: {
  systemPackages = with pkgs; [
    cni
    cni-plugins
  ];
}
