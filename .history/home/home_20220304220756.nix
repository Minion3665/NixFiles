{ config, pkgs, nixpkgs, ... }:
let
  username = "minion";
  homedir = "/home/${username}";

  comma = import ( pkgs.fetchFromGitHub {
      owner = "nix-community";
      repo = "comma";
      rev = "02e3e5545b0c62595a77f3d5de1223c536af0614";
      sha256 = "sha256-WBIQmwlkb/GMoOq+Dnyrk8YmgiM/wJnc5HYZP8Uw72E=";
  }) {};

in {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = username;
  home.homeDirectory = homedir;


  programs.go.enable = true;

  # programs.steam.enable = true;

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "qt";
  };

  nixpkgs.overlays = [ 
    (import ./overlays/anytype.nix)
    (import ./overlays/mindustry.nix)
    (import ./overlays/nur.nix)
  ];

  home.packages = with pkgs; [

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
      pull.rebase = false;
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
