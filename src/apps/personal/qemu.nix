{ pkgs, ... }: {
    home.packages = with pkgs; [
        qemu_full
        virt-manager
        virt-top
    ];
}
