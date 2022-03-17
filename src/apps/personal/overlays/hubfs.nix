final: prev: let
  version = "1ba013d3fe54de01c52bd74d98037fe4c0029d6e";

  src = final.fetchFromGitHub {
    owner = "winfsp";
    repo = "hubfs";
    rev = version;
    hash = "sha256-R1nCdua0gacXrglQ4AZfxnO3ngVECCKKiUOgp3dWRGg=";
  };
in {
  hubfs = final.stdenv.mkDerivation {
    name = "hubfs";
    inherit src version;
    rev = version;

    buildInputs = with final; [
        fuse
        fuse-common
        go
        cmake
    ];

    buildPhase = ''
      make
    '';

    installPhase = ''
      mkdir -p $out/bin
      mv hubfs $out/bin
    '';
  };
}
