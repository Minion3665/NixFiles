{ config, pkgs, nixpkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "minion";
  home.homeDirectory = "/home/minion";

  programs.vscode.enable = true;
  programs.vscode.package = pkgs.vscode-fhs;

  programs.go.enable = true;

  # programs.steam.enable = true;

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "qt";
  };

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball {
      url = "https://github.com/nix-community/NUR/archive/e78eb8016f2b1b20298367804085d6d147557ba0.tar.gz";
      sha256 = "1v2nk8zclpk3r4x9nmi1vsyflwv91a31pchjjhy3gsqs1xcd72kd";
    }) {
      inherit pkgs;
    };
  };

  home.packages = with pkgs; [
    steam-tui steam-run
    minecraft
    git-crypt gnupg pinentry_qt
    spotify
    keepassxc
    grim slurp
    neovim
    qemu
    bind
    file
    nur.repos.kira-bruneau.rofi-wayland
    rofimoji
  ];

  programs.git = {
    enable = true;

    userName = "Skyler Turner";
    userEmail = "skyler@clicksminuteper.net";

    signing = {
      key = "24D31D3B1B986F33";
      signByDefault = true;
      gpgPath = "gpg2";
    };

    lfs.enable = true;
    delta.enable = true;

    extraConfig = {
      init.defaultBranch = "development";
      color.ui = "auto";
      core.autocrlf = "input";
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
