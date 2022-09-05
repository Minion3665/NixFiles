{
  rustPlatform,
  fetchFromGitHub,
  cmake,
  pkg-config,
  freetype,
  fontconfig,
  expat,
  wayland,
  system,
}:
rustPlatform.buildRustPackage rec {
  pname = "waycorner";
  version = builtins.substring 0 7 src.rev;

  src = fetchFromGitHub {
    owner = "Minion3665";
    repo = "waycorner";
    rev = "4a42d986cffa66c535082b3f8fb1c7e7bf278272";
    sha256 = "sha256-OjQPYWtR3a9HZ6h1yXutHlMAfK0G2aRCdtSg9LZh1I0=";
  };

  cargoLock.lockFile = "${src}/Cargo.lock";

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    freetype
    fontconfig
    expat
    wayland
  ];

  postFixup = ''
    patchelf --add-needed ${wayland}/lib/libwayland-client.so $out/bin/waycorner
  '';
}
