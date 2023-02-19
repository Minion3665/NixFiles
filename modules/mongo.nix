{ pkgs, ... }: {
  config = {
    services.mongodb = {
      package = pkgs.mongodb-6_0;
      enable = false;
      dbpath = "/tmp/mongodb";
    };
    internal.allowUnfree = [ "mongodb" "mongodb-compass" ];
  };

  home.home.packages = [ pkgs.mongodb-compass ];
}
