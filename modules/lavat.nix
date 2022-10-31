{ nixpkgs-minion, system, ... }: {
  home.home.packages = [nixpkgs-minion.legacyPackages.${system}.lavat];
}
