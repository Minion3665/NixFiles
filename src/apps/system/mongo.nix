{ nixpkgs-mongodb-fix, system, ... }: {
  services.mongodb = {
    package = (import nixpkgs-mongodb-fix { inherit system; config = { allowUnfree = true; }; }).mongodb-4_4;
    enable = true;
    dbpath = "/tmp/mongodb";
  };
}
