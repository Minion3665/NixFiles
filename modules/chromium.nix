{ pkgs
, username
, ...
}: {
  home.home.packages = [ pkgs.chromium ];

  config.nixpkgs.config.chromium.commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland --enable-features=WebUIDarkMode --force-dark-mode --enable-features=WebRTCPipeWireCapturer";

  config.environment.persistence."/nix/persist".users.${username}.directories = [ ".config/chromium" ];
}
