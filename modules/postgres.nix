{ lib, config, username, pkgs, ... }: {
  config = {
    services = {
      postgresql = {
        enable = true;
        dataDir = "/tmp/postgresql";
        initialScript = pkgs.writeText "init-postgresql" ''
          CREATE ROLE ${username} WITH LOGIN PASSWORD '${username}' CREATEDB;
          GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO ${username};
          GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO ${username};
        '';
      };
      pgadmin = {
        enable = true;
        initialEmail = "skyler3665@gmail.com";
        initialPasswordFile = config.sops.secrets.pgadminPassword.path;
      };
    };
    systemd.services.pgadmin.wantedBy = lib.mkForce [];
    sops.secrets.pgadminPassword = {
      mode = "0400";
      owner = config.users.users.pgadmin.name;
      group = config.users.users.nobody.group;
    };
  };
}
