{ stdenv, p7zip, zip, python3, qt5 }: let
  preExec = ''
  import os
  sfs_select_dir = os.path.expanduser('~/.local/share/Steam/sfs-select/runtime')
  os.makedirs(sfs_select_dir, exist_ok=True)
  os.chdir(sfs_select_dir)


  '';
  preExecBash = builtins.replaceStrings ["\n"] ["\\n"] preExec;
in stdenv.mkDerivation {
  pname = "sfs-select";
  version = "0.5.0";

  src = builtins.fetchurl {
    url = "https://www.unix-ag.uni-kl.de/~t_schmid/sfs-select/sfs-select-0.5.0-full.7z";
    sha256 = "sha256:130ks9vc33r9aycbbz3i8agcy7gjijmfvv94pd4ndxmwl2ndmrh2";
  };
  unpackPhase = ''
    runHook preUnpack

    ${p7zip}/bin/7z x $src -o. -y
    
    runHook postUnpack
  '';

  buildPhase = ''
    runHook preBuild

    mv ./sfs-select/python/sfs-select.py ./sfs-select/python/__main__.py


    sed -i "1i${preExecBash}" ./sfs-select/python/__main__.py
    ${zip}/bin/zip -rj sfs-select.zip ./sfs-select/python/*

    runHook postBuild
  '';

  installPhase = ''
    runHook preBuild

    mkdir -p $out/bin

    echo '#!/usr/bin/env python' | cat - sfs-select.zip > $out/bin/sfs-select

    chmod +x $out/bin/sfs-select

    makeWrapperArgs+=("''${qtWrapperArgs[@]}")
    wrapQtApp $out/bin/sfs-select $makeWrapperArgs

    runHook postBuild
  '';

  nativeBuildInputs = [ p7zip zip qt5.wrapQtAppsHook ];
  buildInputs = [
    (python3.withPackages (pythonPackages: with pythonPackages; [
      psutil
      pyqt5
    ]))
  ];
  dontWrapQtApps = true;
}
