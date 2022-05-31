final: prev: {
  glpaper = prev.glpaper.overrideAttrs (old: rec {
    src = final.fetchFromSourcehut {
      owner = "~scoopta";
      repo = old.pname;
      vc = "hg";
      rev = "f89e60b7941fb60f1069ed51af9c5bb4917aab35";
      sha256 = "sha256-E7FKjt3NL0aAEibfaq+YS2IVvpjNjInA+Rs8SU63/3M=";
    };
  });
}
