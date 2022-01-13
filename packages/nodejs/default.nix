let
  version = "17.3.0";
in { nixpkgs ? import <nixpkgs> {}, stdenv }: {
  inherit version;

  name = "nodejs-${version}";
  src = nixpkgs.fetchurl {
    url = "https://nodejs.org/dist/v${version}/node-v${version}${if stdenv.isDarwin then "-darwin-x64" else "-linux-x64"}.tar.xz"; # this darwin/linux check doesn't work since sha is different for packages
  };

  # Dependencies for building node.js (Python and utillinux on Linux, just Python on Mac)
  buildInputs = with nixpkgs; [ xcbuild binutils-unwrapped patchelf glib python37 ] ++ stdenv.lib.optional stdenv.isLinux utillinux;
  nativeBuildInputs = with nixpkgs; [ autoPatchelfHook ];

  installPhase = ''
    echo "installing nodejs"
    mkdir -p $out
    cp -r ./ $out/
  '';

  meta = with stdenv.lib; {
    description = "Event-driven I/O framework for the V8 JavaScript engine";
    homepage = "https://nodejs.org";
    license = licenses.mit;
  };

  passthru.python = nixpkgs.python37;
}
