{
  pkgs,
  sops-nix,
  ...
}: {
  imports = [
    sops-nix.nixosModules.sops
  ];

  config = {
    environment.systemPackages = with pkgs; [
      sops
    ];
    sops.defaultSopsFile = ../secrets/secrets.json;
  };
}
