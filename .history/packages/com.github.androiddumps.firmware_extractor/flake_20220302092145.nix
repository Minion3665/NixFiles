{
  description = "A flake to build android's partition-tools package";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-21.11;

  outputs = { self, nixpkgs }: {

    src.url = "https://github.com/AndroidDumps/Firmware_extractor.git";
    src.flake = false;

    packages.x86_64-linux.partition-tools =
      with import nixpkgs { system = "x86_64-linux"; };
      stdenv.mkDerivation rec {
        name = "partition-tools";
        unpackPhase = "tar xzf ${src}";
        buildPhase = "g++ -o out *.cc";
        installPhase = "mkdir -p $out/bin && cp out/* $out/bin";
      };

    defaultPackage.x86_64-linux = self.packages.x86_64-linux.partition-tools;

  };
}
