{ username, ... }: {
  config = {
    virtualisation.docker.enable = true;

    users.users.${username}.extraGroups = [ "docker" ];

    environment.persistence."/nix/persist".directories = [
      {
        mode = "0710";
        directory = "/var/lib/docker";
      }
    ];
  };
}
