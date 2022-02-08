final: prev: let
  version = "v135";
  depversion = "v116";

  Mindustry = fetchFromGitHub {
    owner = "Anuken";
    repo = "Mindustry";
    rev = "v${version}";
    sha256 = "URmjmfzQAVVl6erbh3+FVFdN7vGTNwYKPtcrwtt9vkg=";
  };
  Arc = fetchFromGitHub {
    owner = "Anuken";
    repo = "Arc";
    rev = "v${depversion}";
    sha256 = "pUUak5P9t4RmSdT+/oH/8oo6l7rjIN08XDJ06TcUn8I=";
  };
  soloud = fetchFromGitHub {
    owner = "Anuken";
    repo = "soloud";
    # this is never pinned in upstream, see https://github.com/Anuken/Arc/issues/39
    rev = "b33dfc5178fcb2613ee68136f4a4869cadc0b06a";
    sha256 = "1vf68i3pnsixch37285ib7afkwmlrc05v783395jsdjzj9i67lj3";
  };

  unpackPhase = ''
    cp -r ${Mindustry} Mindustry
    cp -r ${Arc} Arc
    chmod -R u+w -- Mindustry Arc
    cp ${prev.stb.src}/stb_image.h Arc/arc-core/csrc/
    cp -r ${soloud} Arc/arc-core/csrc/soloud
    chmod -R u+w -- Arc
  '';

in {
  mindustry-alpha-wayland = prev.mindustry-wayland.overrideAttrs (old: {
    inherit version unpackPhase;
  };
}
