{ lib
, fetchFromGitHub
, python3
}:
let
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

  propagatedBuildInputs = with python3.pkgs; [
    xcffib
    cffi
    cairocffi
    pyopengl
    screeninfo
    glfw
    scipy
    pillow
    poetry-core
    mouse
  ];

  src = fetchFromGitHub {
    owner = "Minion3665";
    repo = "Show";
    rev = "c6ece51bc5d8cae92b5df34598987fb010614004";
    sha256 = "sha256-UZtKefTfWkNlhHl0FKTz80okVC0Hv45BFyw0kn7xz9s=";
  };
}
