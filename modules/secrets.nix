{pkgs, ...}: {
  config = {
    environment.systemPackages = with pkgs; [
      sops
    ];
    sops.defaultSopsFile = ../secrets/secrets.json;
  };
}
