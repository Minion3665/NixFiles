{ lib
, fetchFromGitHub
, python3
, python3Packages
, lowPrio
}: let
  mouse = python3.pkgs.buildPythonPackage rec {
    pname = "mouse";
    version = "0.7.1";

    src = python3.pkgs.fetchPypi {
      inherit pname version format;
      sha256 = "sha256-00u5VIiQCJ/LEZiEAOJvVcYk5se3Qf/3X+39+9N8ABY=";
    };

    format = "wheel";
  };
in
python3.pkgs.buildPythonApplication {
  pname = "Show";
  version = "unstable-2022-11-05";

  format = "pyproject";

  propagatedBuildInputs = with python3Packages; [
    xcffib
    cairocffi
    pyopengl
    screeninfo
    glfw
    scipy
    pillow
    poetry
    mouse
  ];

  src = fetchFromGitHub {
    owner = "Minion3665";
    repo = "Show";
    rev = "c16b2d2b5bd97fe893ae117b0e50808a3d0c611a";
    sha256 = "sha256-ny75uG+7OhbZqw+KUtF/Ow66/rXW/EmHAuThdSB154M=";
  };
}
