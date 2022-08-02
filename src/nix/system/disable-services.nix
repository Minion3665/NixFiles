{ pkgs, ... }: let
    lib = pkgs.lib;
    disabled = [
        "libvirt" "docker" "lxc"  # Can all be enabled by their sockets
        "i2p" "zeronet"  # Rarely used
        "containerd"  # Rarely used
        "openrazer-daemon"  # Headphones have an intermittent hardware fault
    ];
in {
    systemd.services = builtins.listToAttrs (
        map (
            service: {
                name = service;
                value = {
                    wantedBy = lib.mkForce [ ];
                };
            }
        ) disabled
    );
}
