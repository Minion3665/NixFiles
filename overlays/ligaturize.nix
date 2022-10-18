final: prev:
let
  lib = prev.lib;
  fonts = [ "roboto-mono" ];
  ligaturizer = prev.fetchFromGitHub {
    owner = "ToxicFrog";
    repo = "Ligaturizer";
    rev = "v5";
    sha256 = "sha256-sFzoUvA4DB9CVonW/OZWWpwP0R4So6YlAQeqe7HLq50=";
    fetchSubmodules = true;
  };
in
lib.pipe fonts [
  (builtins.map (name: {
    inherit name;
    value = prev.${name};
  }))
  builtins.listToAttrs
  (builtins.mapAttrs (name: value:
    value.overrideAttrs (
      prevAttrs: {
        outputHash = null;
        outputHashMode = null;
        outputHashAlgo = null;
        nativeBuildInputs = (prevAttrs.nativeBuildInputs or [ ]) ++ [ prev.fontforge ];
        postFixup =
          (prevAttrs.postFixup or "")
          + ''
            pushd ${ligaturizer}
            mkdir -p $out/share/fonts/truetype
            mkdir -p $out/share/fonts/opentype
            find $out/share/fonts/truetype \
              -name "*.ttf" \
              -exec fontforge \
              -lang py \
              -script ligaturize.py {} \
              --output-dir=$out/share/fonts/truetype \;
            find $out/share/fonts/opentype \
              -name "*.otf" \
              -exec fontforge \
              -lang py \
              -script ligaturize.py {} \
              --output-dir=$out/share/fonts/opentype \;
            popd
          '';
      }
    )))
]
