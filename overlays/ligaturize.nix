final: prev: let
  lib = prev.lib;
  fonts = ["roboto-mono"];
  ligaturizer = prev.fetchFromGithub {
    owner = "ToxicFrog";
    repo = "Ligaturizer";
    rev = "v5";
    sha256 = lib.fakeSha256;
  };
in
  lib.pipe fonts [
    (builtins.map (name: {
      inherit name;
      value = prev.${name};
    }))
    (builtins.mapAttrs (name: value:
      value.overrideAttrs (
        prevAttrs: {
          postPatch = prevAttrs.postPatch + ''
          find $out -name "*.ttf" -exec fontforge -lang py -script ligaturize.py {} \;
          find $out -name "*.otf" -exec fontforge -lang py -script ligaturize.py {} \;
          false
          '';
        }
      )))
    builtins.listToAttrs
  ]
