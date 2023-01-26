{ nixpkgs-mindustry
, system
, ...
}: {
  home.home.packages = [
    nixpkgs-mindustry.legacyPackages.${system}.mindustry
  ];
}
