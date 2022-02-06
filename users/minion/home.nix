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

  programs.vscode.enable = true;
  programs.vscode.package = pkgs.vscode-fhs;

  programs.go.enable = true;

  # programs.steam.enable = true;

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "qt";
  };

  nixpkgs.overlays = [ 
    (import ./overlays/anytype.nix)
    (import ./overlays/nur.nix)
  ];

  home.packages = with pkgs; [
    steam-tui steam-run
    minecraft
    git-crypt gnupg pinentry_qt
    spotify
    keepassxc
    grim slurp
    neovim helix
    qemu
    bind
    file
    nur.repos.kira-bruneau.rofi-wayland
    rofimoji
    anytype-latest
    htop
    hue-cli
    thefuck
    comma
  ];

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck" ];
      theme = "crunch";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
      expireDuplicatesFirst = true;
      extended = true;
    };
    initExtra = ''
      bindkey "\'\'$\{key[Up]}" up-line-or-search

      command_not_found_handler ()
      {
          local p='/nix/store/ycclzpk99snlrk8sg9n4j8pm1927gavw-command-not-found/bin/command-not-found';
          if [ -x "$p" ] && [ -f '/nix/var/nix/profiles/per-user/root/channels/nixos/programs.sqlite' ]; then
               , "$@";
              echo "$p"
              echo "$@"
              "$p" "$@";
              if [ $? = 126 ]; then
                  "$@";
              else
                  return 127;
              fi;
          else
              echo "$1: command not found" 1>&2;
              return 127;
          fi
      }
    '';
    enableSyntaxHighlighting = true;
    enableAutosuggestions = true;
    autocd = true;
    dotDir = ".local/share/zsh";
  };

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
