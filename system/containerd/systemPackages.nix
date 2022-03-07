{ pkgs, ... }: {
  systemPackages = with pkgs; [
    cni-plugins
  ];
}
