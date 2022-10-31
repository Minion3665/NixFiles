{ rustPlatform
, fetchFromGitHub
, cmake
, pkg-config
, freetype
, fontconfig
, expat
, wayland
, system
,
}:
rustPlatform.buildRustPackage rec {
  pname = "waycorner";
  version = builtins.substring 0 7 src.rev;

  src = fetchFromGitHub {
    owner = "Minion3665";
    repo = "waycorner";
    rev = "ef3bd723a9a8673328c12fc8c7f210864787e5d1";
    sha256 = "sha256-iPeF84tC3IEYECm04KwmTjOaYVSUMh2dBlijzGnxoyw=";
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
