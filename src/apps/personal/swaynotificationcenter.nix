{ nixpkgs-unstable, ... }: {
  home.packages = with nixpkgs-unstable; [
    swaynotificationcenter 
  ]; 
}
