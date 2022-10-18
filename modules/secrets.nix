{ pkgs
, sops-nix
, ...
}: {
  imports = [
    sops-nix.nixosModules.sops
  ];

  config = {
    environment.systemPackages = with pkgs; [
      sops
    ];
    sops = {
      defaultSopsFile = ../secrets/secrets.json;
      gnupg.sshKeyPaths = [ "/nix/persist/etc/ssh/ssh_host_rsa_key" ];
      age.sshKeyPaths = [ ];
    };
  };
}
