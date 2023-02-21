{ lib
, fetchFromGitHub
, python3
, python3Packages
, lowPrio
, fetchpatch
, poetry
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
    rev = "24deb2dc992861a3ec4c1c342ce7f85b6953f8b5";
    sha256 = "sha256-VmtGOmATN38RVXa4N44vtaXT7r2sl0YE2K5q7LKhL7M=";
  };
}
