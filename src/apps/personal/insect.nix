{ pkgs, ... }: {
    home.packages = with pkgs; [
        nodePackages.insect
    ];
}
