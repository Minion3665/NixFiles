{ lib
, fetchFromGitHub
, pkg-config
, openssl
, system
, _tooling
, packageSets
, ...
}:
let
  craneLib = _tooling.crane.lib.${system}.overrideToolchain
    packageSets.fenix.latest.toolchain;
in
craneLib.buildPackage
rec {
  pname = "enso";
  version = "2023.1.1-nightly.2023.1.24";

  src = craneLib.cleanCargoSource (fetchFromGitHub {
    owner = "enso-org";
    repo = "enso";
    rev = version;
    sha256 = "sha256-kwUIIVhw9fb5FlAxlQxcgalIHZ9nz4ey3CSzbQgMyQM=";
  });

  buildInputs = [ openssl.dev ];
  nativeBuildInputs = [ pkg-config ];
}
