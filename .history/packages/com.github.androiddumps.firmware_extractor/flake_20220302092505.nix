{
  description = "A flake to build android's partition-tools package";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-21.11;

  inputs.src.url = "https://github.com/AndroidDumps/Firmware_extractor.git";
  inputs.src.flake = false;

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.partition-tools =
      with import nixpkgs { system = "x86_64-linux"; };
      stdenv.mkDerivation {
        name = "partition-tools";
        installPhase = "mkdir -p $out/bin && cp ${src}/tools/Linux/bin/* $out/bin && cp ${src}/tools/Linux/bin/bin/* $out/bin";
      };

    defaultPackage.x86_64-linux = self.packages.x86_64-linux.partition-tools;

  };
}
