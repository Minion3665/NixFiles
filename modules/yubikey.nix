{ pkgs, username, ... }: {
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
    yubioath-desktop
  ];
}
