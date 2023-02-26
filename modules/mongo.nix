{ pkgs, nixpkgs-unfree, system, lib, ... }: {
  config = {
    services.mongodb = {
      package = nixpkgs-unfree.legacyPackages.${system}.mongodb-6_0;
      enable = true;
      dbpath = "/tmp/mongodb";
    };
    internal.allowUnfree = [ "mongodb" "mongodb-compass" ];
    systemd.services.mongod.wantedBy = lib.mkForce [];
  };

  home.home.packages = [ pkgs.mongodb-compass ];
}
