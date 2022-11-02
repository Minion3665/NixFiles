{ pkgs
, username
, ...
}: {
  home = {
    programs.gpg.enable = true;
    services.gpg-agent = {
      enable = true;
      /* extraConfig = '' */
      /*   default-cache-ttl 86400 */
      /*   max-cache-ttl 86400 */
      /*   pinentry-program ${pkgs.pinentry-rofi}/bin/pinentry-rofi */
      /*   auto-expand-secmem */
      /* ''; */
      pinentryFlavor = "curses";
    };
  };

  config.environment.persistence."/nix/persist".users.${username}.directories = [
    {
      directory = ".gnupg";
      mode = "0700";
    }
  ];

  home.home.packages = [
    pkgs.pinentry-rofi
  ];
}
