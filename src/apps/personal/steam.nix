{ pkgs, ... }: {
    home.packages = with pkgs; [
        steam-run
        proton-caller
    ];

    # Due to opening the firewall and creating udev rules,
    # steam proper can only be installed in the main system configuration.

    # Steam-run is a FHS-compliant wrapper (around any executable), which
    # we can run here, but the main steam package is not here

    # Proton-caller is a windows-exe caller which runs windows programs using
    # Proton
}
