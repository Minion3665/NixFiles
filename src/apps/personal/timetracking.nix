{ pkgs, ... }: {
    home.packages = [
        pkgs.gtimelog
        pkgs.haskellPackages.arbtt
    ];
}
