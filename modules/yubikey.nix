{ pkgs
, username
, system
, nixpkgs-yubioath-flutter
, ...
}: {
  config = {
    security.pam.yubico = {
      enable = true;
      mode = "challenge-response";
    };
    services = {
      udev.packages = [ pkgs.yubikey-personalization ];
      pcscd.enable = true;
    };
    environment.persistence."/nix/persist".users.${username}.directories = [
      ".yubico"
    ];
  };
  home.home.packages = with pkgs; [
    yubikey-personalization
    yubico-pam
    nixpkgs-yubioath-flutter.legacyPackages.${system}.yubioath-flutter
  ];
}
