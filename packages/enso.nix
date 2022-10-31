{ lib, rustPlatform, fetchFromGitHub, packageSets, pkg-config, openssl, ... }:
rustPlatform.buildRustPackage.override
{
  rustc = packageSets.fenix.minimal.rustc;
}
rec {
  pname = "enso";
  version = "2022.1.1-nightly.2022-10-19";

  src = fetchFromGitHub {
    owner = "enso-org";
    repo = "enso";
    rev = version;
    sha256 = "sha256-YCTDxKVzrEDW+LWLyNC/GXh4WfcAuPtwo8VpSllYycI=";
  };

  buildInputs = [ openssl.dev ];
  nativeBuildInputs = [ pkg-config ];

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
    outputHashes = {
      "console_error_panic_hook-0.1.7" = "sha256-1RhnLNB04DlsOuBis0bjRLPlJ+hvMF+n+olOaTF2TjM=";
      "octocrab-0.17.0" = "sha256-0qJvDrwi2FARHyi8597fYJ8V2LuKiZXh9+Hy/2DsBTM=";
    };
  };
}
