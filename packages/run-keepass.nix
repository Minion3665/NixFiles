{ keepassxc, coreutils, stdenv }: stdenv.mkDerivation {
  pname = "run-keepass";
  version = "2023-02-11";

  src = ./run-keepass;

  buildInputs = [
    keepassxc
    coreutils
  ];
}
