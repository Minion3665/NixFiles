{
  config = {
    environment.persistence."/nix/persist".files = [
      "/etc/machine-id"
    ];
  };
}
