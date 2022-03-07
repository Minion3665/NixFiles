{ pkgs, ... }: {
  systemPackages = with pkgs; [
    (lowPrio cni)
    cni-plugins
  ];
}
