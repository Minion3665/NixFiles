{ pkgs, ... }: {
    home.packages = with pkgs; [
        hollywood
    ];
}
