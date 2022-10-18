{ stdenv
, #qt5-declarative,
  libsForQt5
, extra-cmake-modules
, #kdoctools,
  eigen
, #qt5-tools,
  fetchurl
,
}:
stdenv.mkDerivation {
  pname = "analitza";
  version = "21.12.2";
  dontWrapQtApps = true;

  src = fetchurl {
    url = "https://download.kde.org/stable/release-service/21.12.2/src/analitza-21.12.2.tar.xz";
    sha256 = "a4c52d0ea51870495c2da25a58c7495af14e9d71a380d20aea9c1dd39de762aa";
  };

  buildInputs = [ extra-cmake-modules ];
  nativeBuildInputs = [
    libsForQt5.qt5.qtdeclarative
    libsForQt5.kdoctools
    libsForQt5.qt5.qttools
    eigen
  ];
}
