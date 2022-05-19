{
  description = "A flake to build android's partition-tools package";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-21.11;

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.partition-tools =
      with import nixpkgs { system = "x86_64-linux"; };
      stdenv.mkDerivation {
        name = "partition-tools";
        src = fetchurl { url = "https://android.googlesource.com/platform/system/extras/+archive/master/partition_tools.tar.gz" };
        buildPhase = "tar xzf partition_tools.tar.gz && g++ -o *.cc ";
      }

    defaultPackage.x86_64-linux = self.packages.x86_64-linux.partition-tools;

  };
}
