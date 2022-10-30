{ pkgs, ... }: {
  config = {
    services.mongodb = {
    package = pkgs.mongodb-4_2;
    enable = true;
    dbpath = "/tmp/mongodb";
    };
    internal.allowUnfree = ["mongodb" "mongodb-compass"];
  };

  home.home.packages = [pkgs.mongodb-compass];
}
