{ pkgs, ... }: {
    home.packages = with pkgs; [
        hubfs
        fuse
        fuse3
        fuse-common
    ];
}
