{
  description = "A flake to build android's partition-tools package";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-21.11;

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.partition-tools = nixpkgs.legacyPackages.x86_64-linux.hello;

    defaultPackage.x86_64-linux = self.packages.x86_64-linux.partition-tools;

  };
}
