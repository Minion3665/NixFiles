{ pkgs, nixpkgs-unfree, system, username, lib, ... }: {
  config = {
    services.mongodb = {
      package = pkgs.legacyPackages.${system}.mongodb-6_0;
      enable = false;
      dbpath = "/tmp/mongodb";
    };
    internal.allowUnfree = [ "mongodb" "mongodb-compass" ];
    systemd.services.mongod.wantedBy = lib.mkForce [];
    environment.persistence."/nix/persist".users.${username}.directories = [
      ".config/MongoDB\ Compass/Connections/"
    ];
  };

  home.home.packages = [ pkgs.mongodb-compass ];
}
