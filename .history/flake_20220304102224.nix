{
  description = "Minion3665's NixFiles (since 2022-03-24)";

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    defaultPackage.x86_64-linux = self.packages.x86_64-linux.hello;

  };
}
