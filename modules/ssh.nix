{
  config = {
    services.openssh.enable = true;

    environment.persistence."/nix/persist".files = [
      {
        file = "/etc/ssh_host_rsa_key";
        parentDirectory = {mode = 755;};
      }
      {
        file = "/etc/ssh_host_rsa_key.pub";
        parentDirectory = {mode = 755;};
      }
      {
        file = "/etc/ssh_host_ed25519_key";
        parentDirectory = {mode = 755;};
      }
      {
        file = "/etc/ssh_host_ed25519_key.pub";
        parentDirectory = {mode = 755;};
      }
    ];
  };
}
