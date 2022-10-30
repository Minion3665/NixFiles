final: prev: {
  aerc = prev.aerc.overrideAttrs (prevAttrs: rec {
    buildInputs = prevAttrs.buildInputs ++ [final.gawk];
    pythonPath = prevAttrs.pythonPath ++ [final.python3.pkgs.vobject];
    postFixup =
      prevAttrs.postFixup
      + ''
        wrapProgram $out/share/aerc/filters/show-ics-details.py --prefix \
        PYTHONPATH : ${final.python3.pkgs.makePythonPath pythonPath}
      '';
  });
}
