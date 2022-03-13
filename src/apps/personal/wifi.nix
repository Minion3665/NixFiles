{ pkgs, ... }: {
    home.packages = with pkgs; [
        wpa_supplicant_gui
    ];
}
