{ fetchFromGitHub
, nodejs
, stdenv
, callPackage
, gnused
}:
let
  nodeDependencies = (callPackage ./etherpad { }).nodeDependencies;
in
stdenv.mkDerivation rec {
  pname = "etherpad";
  version = "1.8.18";

  src = fetchFromGitHub {
    owner = "ether";
    repo = "etherpad-lite";
    rev = version;
    sha256 = "sha256-FziTdHmZ7DgWlSd7AhRdZioQNEPmiGZFHjc8pwnpKIo=";
  };

  buildInputs = [
    nodejs
  ];

  buildPhase = ''
    ln -s ${nodeDependencies}/lib/node_modules ./src/node_modules
    export PATH="${nodeDependencies}/bin:$PATH"
  '';

  installPhase = ''
    mkdir $out
    cp ./* $out -r

    mv $out/bin/fastRun.sh $out/bin/etherpad
    sed -i "s#^cd .*#cd $out/#g" $out/bin/etherpad
    chmod +x $out/bin/etherpad
  '';
}
