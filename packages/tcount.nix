{ rustPlatform
, fetchFromGitHub
, cmake
, pkg-config
, system
, _tooling
,
}: let
  craneLib = _tooling.crane.lib.${system};
  rev = "71638e6540e2fc30bd609f8f78131ec10217f906";
in craneLib.buildPackage {
  pname = "tcount";
  version = builtins.substring 0 7 rev;

  src = craneLib.cleanCargoSource (fetchFromGitHub {
    owner = "RRethy";
    repo = "tcount";
    inherit rev;
    sha256 = "sha256-PrRfk/4wRADNASLmcPIpxs+flAd3S/k1OWBaY3GRJHE=";
  });

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  doCheck = false;
}
