{ pkgs, lib, nurpkgs, ... }:
let
    variables = import ./common/variables.nix;
    personalPackages = import ./utils/nixFilesIn.nix lib ./apps/personal;
    personalScripts = import ./utils/nixFilesIn.nix lib ./scripts/personal;
    overlays = import ./utils/nixFilesIn.nix lib ./overlays;
    packages = import ./utils/nixFilesIn.nix lib ./packages;
in {
    imports = personalPackages ++ personalScripts;

    nixpkgs.overlays = map (f: import f) overlays ++ [
        (self: (super: builtins.listToAttrs (
            map (f: {
                name = builtins.elemAt (builtins.match "^(.*/)*(.*)\\.nix$" (toString f)) 1;
                value = super.lib.callPackageWith (self) (import f) {};
            }) packages
        )))
        nurpkgs.overlay
    ];

    home.packages = with pkgs; [  # New apps should be on new lines
        anytype
        minecraft
	binutils
	cmake
	gcc
	gnumake
	helvum
	libfprint
	libtool
	pulsemixer
	spotifyd
	steam
	swaybg
	teams
	xdg-desktop-portal
	xdg-desktop-portal-wlr
	zoom
        git-crypt
        keepassxc
        grim slurp
        helix
#        qemu
        bind
        file
        rofi-wayland
        rofimoji
        htop
        hue-cli
        zip
        element
        tdesktop
    ];  # Legacy field; please don't add new packages here, instead create a file in ./apps/personal
}
