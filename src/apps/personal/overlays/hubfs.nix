final: prev: let
  src = final.fetchFromGitHub {
    owner = "winfsp";
    repo = "hubfs";
    rev = "1ba013d3fe54de01c52bd74d98037fe4c0029d6e";
    hash = "sha256-R1nCdua0gacXrglQ4AZfxnO3ngVECCKKiUOgp3dWRGg=";
  } + "/src";
in {
  hubfs = final.buildGoModule {
    name = "hubfs";
    buildInputs = with final; [
        fuse
    ];
    checkPhase = ":"; # Bit of a hack here; we need to disable tests as we can't get FUSE inside the build derivation to test the package
    inherit src;
    vendorSha256 = "sha256-Fpa+wanlMIqxkEZ3JQdCT4ixuNBj7AquG2+wLuO5TQU=";
    runVend = true;
  };
}
