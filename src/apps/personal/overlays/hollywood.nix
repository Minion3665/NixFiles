final: prev: let
  hollywood = stdenv.mkDerivation {
    name = "hollywood-1.7";

    src = fetchgit {
      url = https://github.com/dustinkirkland/hollywood.git;
      rev = "58e1e15e6f02cb05c2cad8163c27dabc98e3f19f";
      sha256 = "4a0e4d499bd00da76f17c35518dee56c5eecd6c9a582f26bd52d119505e3f61a";
    };

    buildInputs = [ makeWrapper ];

    patchPhase = ''
      substituteInPlace bin/hollywood \
        --replace /bin/bash ${bash}/bin/bash
    '';

    installPhase = ''
      # Create the output directory and copy the core files into that
      # directory.
      mkdir -p $out
      cp -R bin share $out
      # Only install the supported plugins.
      mkdir -p $out/lib/hollywood
      cp lib/hollywood/apg $out/lib/hollywood
      cp lib/hollywood/bmon $out/lib/hollywood
      cp lib/hollywood/cmatrix $out/lib/hollywood
      cp lib/hollywood/hexdump $out/lib/hollywood
      cp lib/hollywood/htop $out/lib/hollywood
      cp lib/hollywood/logs $out/lib/hollywood
      cp lib/hollywood/mplayer $out/lib/hollywood
      cp lib/hollywood/sshart $out/lib/hollywood
      cp lib/hollywood/stat $out/lib/hollywood
      cp lib/hollywood/tree $out/lib/hollywood
      # Wrap `hollywood` so that it has the paths to all of the tools
      # required by the plugins (and hollywood itself).
      wrapProgram $out/bin/hollywood \
        --suffix-each PATH : "${final.apg}/bin ${final.bmon}/bin ${final.byobu}/bin ${final.ccze}/bin ${final.cmatrix}/bin ${final.htop}/bin ${final.mplayer}/bin ${final.openssh}/bin ${final.tmux}/bin ${final.tree}/bin"
    '';
  }
in {
  hollywood = hollywood;
}
