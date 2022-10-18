{ pkgs
}: with pkgs; let
  hash = "e82b59795985540062f4c00e582dc42e8b8358e8";
in
stdenv.mkDerivation rec {
  version = builtins.substring 0 7 hash;
  src = builtins.fetchGit {
    url = "https://github.com/KDE/kalgebra";
    rev = hash;
  };
  name = "kalgebra-${version}";
  nativeBuildInputs = [ extra-cmake-modules qt5.wrapQtAppsHook ];
  buildInputs = with qt5; with libsForQt5; [
    qtbase
    qtquickcontrols
    kconfig
    kcoreaddons
    kcrash
    kconfigwidgets
    kdbusaddons
    kdoctools
    ktextwidgets
    kxmlgui
    kdeApplications.libkdegames
    kcompletion
    analitza
    kirigami2
  ];
}
