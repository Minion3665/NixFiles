# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../secrets/networking-configuration.nix
      ./packaging-configuration.nix
      ./containerd/containerd.nix
    ];

  # Prepare nix flakes
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.useOSProber = true;

  # Enable emulated systems
  boot.binfmt.emulatedSystems = [ "aarch64-linux" "armv6l-linux" ];

  # Enable apparmor
  security.apparmor.enable = true;
  security.apparmor.killUnconfinedConfinables = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "uk";
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
      # xfce.enable = true;
    };
    # displayManager.startx.enable = true;
    displayManager.sddm.enable = true;
  };

  # And wayland
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # so that gtk works properly
    extraPackages = with pkgs; [
      swaylock
      swayidle
      wl-clipboard
      mako # notification daemon
      alacritty # Alacritty is the default terminal in the config
    ];
  };

  programs.qt5ct.enable = true;
  programs.waybar.enable = false; # true;

  # Get screensharing to work
  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
      gtkUsePortal = true;
      wlr.enable = true;
      
    };
  };

  # Configure keymap in X11
  services.xserver.layout = "gb";
  # services.xserver.xkbOptions = "eurosign:e";
 

  # Permit and install steam
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-runtime"
  ];

  programs.steam.enable = true;


  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    config.pipewire = {
      "context.exec" = [
        {
          path = "/usr/bin/pipewire";
          args = "-c /etc/pipewire/7.1-surround-sound.conf";
        }
      ];
    };
  };
  environment.etc."pipewire/7.1-surround-sound.conf".source = ./pipewire/7.1-surround-sound.conf;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.minion = {
    isNormalUser = true;
    extraGroups = [ "wheel" "kvm" "docker" "containerd" "dialout" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim  # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    ((emacsPackagesNgGen emacs).emacsWithPackages (epkgs: [
      epkgs.vterm
      epkgs.emacsql-sqlite
    ]))  # Emacs + vterm-module (needed for vterm)
    wget
    firefox
    chromium  # Install chromium if needed
    texlive.combined.scheme-full
    keybase-gui
    bluez
    macchanger
    comic-relief
    qemu_kvm
    polkit_gnome
    gtk-engine-murrine
    gtk_engines
    gsettings-desktop-schemas
    lxappearance
  ] ++ (import ./containerd/systemPackages.nix pkgs).systemPackages;

#  environment.systemPackages = [
#    import /scripts/jetbrains.rider.nix
#  ];

  fonts.fonts = with pkgs; [
    nerdfonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts
    dina-font
    proggyfonts
    roboto
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.kdeconnect.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.keybase.enable = true;
  services.kbfs.enable = true;
  services.kbfs.enableRedirector = true;
  security.wrappers.keybase-redirector.owner = "root";
  security.wrappers.keybase-redirector.group = "root";
  services.gnome.gnome-keyring.enable = true;
  services.i2p.enable = true;
  services.tlp.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = false;

  hardware.bluetooth.enable = true;

  environment.pathsToLink = [ "/share/zsh" "/libexec" ];

  virtualisation.libvirtd.qemu.package = pkgs.qemu_kvm;
  virtualisation.kvmgt.enable = true;

  services.openvpn.servers = {
    clicks = { config = '' config /home/minion/Nix/secrets/clicks/client.ovpn ''; };
  };

  nixpkgs.overlays = [
    (self: super: {
      polkit = super.polkit.overrideAttrs (oldAttrs: {
        patches = oldAttrs.patches ++ [
          (super.fetchpatch {
            url = "https://gitlab.freedesktop.org/polkit/polkit/-/commit/716a273ce0af467968057f3e107156182bd290b0.patch";
            sha256 = "sha256-hOJJhUmxXm87W1ZU9Y1NJ8GCyKvPjbIVtCHlhRGlN8k=";
          })];
      });
    })
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}

