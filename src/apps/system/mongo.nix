{ system, pkgs-unstable, ... }: {
  services.mongodb = {
    package = pkgs-unstable.mongodb-4_2;
    enable = true;
    dbpath = "/tmp/mongodb";
  };
}
