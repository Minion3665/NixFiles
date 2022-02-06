{ config, pkgs, nixpkgs, ... }:
let
  username = "minion";
  homedir = "/home/${username}";
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
  ];

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "zsh-autosuggestions" "zsh-syntax-highlighting" "git" "thefuck" ];
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
    '';
    enableSyntaxHighlighting = true;
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
