{ pkgs, lib, modulesPath, config, ... }:
let
    nixScripts = import ./utils/nixFilesIn.nix lib ./nix/system;
    nixApps = import ./utils/nixFilesIn.nix lib ./apps/system;
in {
    imports = nixScripts ++ nixApps ++ [ (modulesPath + "/installer/scan/not-detected.nix") ];


  # Prepare nix flakes
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
      auto-optimise-store = true
    '';
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.useOSProber = true;

  # Enable emulated systems
  boot.binfmt.emulatedSystems = [ "aarch64-linux" "armv6l-linux" ];

  boot.resumeDevice = "/dev/nvme0n1p5";

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
    displayManager.startx.enable = true;
    # displayManager.sddm.enable = true;
  };

  services.zeronet.enable = true;
  services.zeronet.package = pkgs.zeronet-conservancy;

  services = {
    syncthing = {
        enable = true;
        user = "minion";
        dataDir = "/home/minion/Documents";    # Default folder for new synced folders
        configDir = "/home/minion/.config/syncthing";   # Folder for Syncthing's settings and keys
    };
  };

  # And wayland
/*  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # so that gtk works properly
    extraPackages = with pkgs; [
      swaylock
      swayidle
      wl-clipboard
      mako # notification daemon
      alacritty # Alacritty is the default terminal in the config
    ];
  };*/

  programs.light.enable = true; # Needs udev rules to properly work

  programs.qt5ct = {
    enable = true;
  };
#  programs.waybar.enable = false; # true;

  # Get screensharing to work
  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-kde
      ];
      gtkUsePortal = true;
      wlr.enable = true;     
    };
  };

  systemd.user.services.xdg-desktop-portal = {
    unitConfig = {
      After = "graphical-session.target";
    };
  };

  # Configure keymap in X11
  services.xserver.layout = "gb";
  # services.xserver.xkbOptions = "eurosign:e";
  services.upower.enable = true;

  # Permit and install steam
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-runtime"
    "mongodb"
    "nvidia-x11"
    "nvidia-settings"
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
    /*config.pipewire = {
      "context.modules" = [
        {
          name = "libpipewire-module-filter-chain";
          args = {
            "node.name"        = "effect_output.virtual-surround-7.1-hesuvi";
            "node.description" = "Virtual Surround Sink";
            "media.name"       = "Virtual Surround Sink";
            nodes = [
              # duplicate inputs
              { type = "builtin"; label = "copy"; name = "copyFL";  }
              { type = "builtin"; label = "copy"; name = "copyFR";  }
              { type = "builtin"; label = "copy"; name = "copyFC";  }
              { type = "builtin"; label = "copy"; name = "copyRL";  }
              { type = "builtin"; label = "copy"; name = "copyRR";  }
              { type = "builtin"; label = "copy"; name = "copySL";  }
              { type = "builtin"; label = "copy"; name = "copySR";  }
              { type = "builtin"; label = "copy"; name = "copyLFE"; }

              # apply hrir - HeSuVi 14-channel WAV (not the *-.wav variants) (note: 44 in HeSuVi are the same, but resampled to 44100)
              { type = "builtin"; label = "convolver"; name = "convFL_L"; config = { filename = "hrir_hesuvi/hrir.wav"; channel =  0; }; }
              { type = "builtin"; label = "convolver"; name = "convFL_R"; config = { filename = "hrir_hesuvi/hrir.wav"; channel =  1; }; }
              { type = "builtin"; label = "convolver"; name = "convSL_L"; config = { filename = "hrir_hesuvi/hrir.wav"; channel =  2; }; }
              { type = "builtin"; label = "convolver"; name = "convSL_R"; config = { filename = "hrir_hesuvi/hrir.wav"; channel =  3; }; }
              { type = "builtin"; label = "convolver"; name = "convRL_L"; config = { filename = "hrir_hesuvi/hrir.wav"; channel =  4; }; }
              { type = "builtin"; label = "convolver"; name = "convRL_R"; config = { filename = "hrir_hesuvi/hrir.wav"; channel =  5; }; }
              { type = "builtin"; label = "convolver"; name = "convFC_L"; config = { filename = "hrir_hesuvi/hrir.wav"; channel =  6; }; }
              { type = "builtin"; label = "convolver"; name = "convFR_R"; config = { filename = "hrir_hesuvi/hrir.wav"; channel =  7; }; }
              { type = "builtin"; label = "convolver"; name = "convFR_L"; config = { filename = "hrir_hesuvi/hrir.wav"; channel =  8; }; }
              { type = "builtin"; label = "convolver"; name = "convSR_R"; config = { filename = "hrir_hesuvi/hrir.wav"; channel =  9; }; }
              { type = "builtin"; label = "convolver"; name = "convSR_L"; config = { filename = "hrir_hesuvi/hrir.wav"; channel = 10; }; }
              { type = "builtin"; label = "convolver"; name = "convRR_R"; config = { filename = "hrir_hesuvi/hrir.wav"; channel = 11; }; }
              { type = "builtin"; label = "convolver"; name = "convRR_L"; config = { filename = "hrir_hesuvi/hrir.wav"; channel = 12; }; }
              { type = "builtin"; label = "convolver"; name = "convFC_R"; config = { filename = "hrir_hesuvi/hrir.wav"; channel = 13; }; }

              # treat LFE as FC
              { type = "builtin"; label = "convolver"; name = "convLFE_R"; config = { filename = "hrir_hesuvi/hrir.wav"; channel = 13; }; }
              { type = "builtin"; label = "convolver"; name = "convLFE_L"; config = { filename = "hrir_hesuvi/hrir.wav"; channel =  6; }; }

              # stereo output
              { type = "builtin"; label = "mixer"; name = "mixR"; }
              { type = "builtin"; label = "mixer"; name = "mixL"; }
            ];
            links = [
              # input
              { output = "copyFL:Out";  input="convFL_L:In";  }
              { output = "copyFL:Out";  input="convFL_R:In";  }
              { output = "copySL:Out";  input="convSL_L:In";  }
              { output = "copySL:Out";  input="convSL_R:In";  }
              { output = "copyRL:Out";  input="convRL_L:In";  }
              { output = "copyRL:Out";  input="convRL_R:In";  }
              { output = "copyFC:Out";  input="convFC_L:In";  }
              { output = "copyFR:Out";  input="convFR_R:In";  }
              { output = "copyFR:Out";  input="convFR_L:In";  }
              { output = "copySR:Out";  input="convSR_R:In";  }
              { output = "copySR:Out";  input="convSR_L:In";  }
              { output = "copyRR:Out";  input="convRR_R:In";  }
              { output = "copyRR:Out";  input="convRR_L:In";  }
              { output = "copyFC:Out";  input="convFC_R:In";  }
              { output = "copyLFE:Out"; input="convLFE_L:In"; }
              { output = "copyLFE:Out"; input="convLFE_R:In"; }

              # output
              { output = "convFL_L:Out";  input="mixL:In 1"; }
              { output = "convFL_R:Out";  input="mixR:In 1"; }
              { output = "convSL_L:Out";  input="mixL:In 2"; }
              { output = "convSL_R:Out";  input="mixR:In 2"; }
              { output = "convRL_L:Out";  input="mixL:In 3"; }
              { output = "convRL_R:Out";  input="mixR:In 3"; }
              { output = "convFC_L:Out";  input="mixL:In 4"; }
              { output = "convFC_R:Out";  input="mixR:In 4"; }
              { output = "convFR_R:Out";  input="mixR:In 5"; }
              { output = "convFR_L:Out";  input="mixL:In 5"; }
              { output = "convSR_R:Out";  input="mixR:In 6"; }
              { output = "convSR_L:Out";  input="mixL:In 6"; }
              { output = "convRR_R:Out";  input="mixR:In 7"; }
              { output = "convRR_L:Out";  input="mixL:In 7"; }
              { output = "convLFE_R:Out"; input="mixR:In 8"; }
              { output = "convLFE_L:Out"; input="mixL:In 8"; }
            ];
            inputs  = [ "copyFL:In" "copyFR:In" "copyFC:In" "copyLFE:In" "copyRL:In" "copyRR:In" "copySL:In" "copySR:In" ];
            outputs = [ "mixL:Out" "mixR:Out" ];
          };
          "capture.props" = {
              "media.class"    = "Audio/Sink";
              "audio.channels" = 8;
              "audio.position" = [ "FL" "FR" "FC" "LFE" "RL" "RR" "SL" "SR" ];
          };
          "playback.props" = {
              "node.passive"   = true;
              "audio.channels" = 2;
              "audio.position" = [ "FL" "FR" ];
          };
        }
      ];
    };*/
  };
  environment.etc."pipewire/7.1-surround-sound.conf".source = ./pipewire/7.1-surround-sound.conf;

  hardware.openrazer.enable = true;
  hardware.openrazer.users = [ "minion" ];

  hardware.steam-hardware.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  programs.dconf.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.minion = {
    isNormalUser = true;
    extraGroups = [ "wheel" "kvm" "docker" "containerd" "dialout" "libvirtd" "video" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim  # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    ((emacsPackagesFor emacs).emacsWithPackages (epkgs: [
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
    libsForQt5.qt5.qtwayland
    texworks
    wlogout
    wob
    wlsunset
    cni-plugins
  ];

#  environment.systemPackages = [
#    import /scripts/jetbrains.rider.nix
#  ];

  nixpkgs.config.chromium.commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland --enable-features=WebUIDarkMode --force-dark-mode --enable-features=WebRTCPipeWireCapturer --enable-gpu";

  services.mongodb = {
    package = pkgs.mongodb-5_0;
    enable = true;
    dbpath = "/tmp/mongodb";
  };

  fonts = {
    fonts = with pkgs; [
      nerdfonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      mplus-outline-fonts.githubRelease
      dina-font
      proggyfonts
      roboto
      roboto-mono
      roboto-slab
      twemoji-color-font
      ubuntu_font_family
    ];

    enableDefaultFonts = true;
    fontDir.enable = true;

    fontconfig = {
      defaultFonts = {
        serif = [ "Roboto Slab" ];
        sansSerif = [ "Roboto" "Ubuntu" ];
        monospace = [ "Roboto Mono" "Ubuntu Mono" ];
        emoji = [ "Twitter Color Emoji" ];
      };
    };
  };

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
  security.wrappers.keybase-redirector.group = "users";
  services.gnome.gnome-keyring.enable = true;
  services.i2p.enable = true;
  services.tlp.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = false;
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.onBoot = "ignore";

  hardware.bluetooth.enable = true;

  environment.pathsToLink = [ "/share/zsh" "/libexec" ];

  virtualisation.libvirtd.qemu.package = pkgs.qemu_kvm;
  virtualisation.kvmgt.enable = true;

  services.openvpn.servers = {
    clicks = { config = '' config /home/minion/Nix/secrets/clicks/client.ovpn ''; };
  };

  environment.etc = {
    "pam.d/swaylock" = {
      mode = "0644";
      text = ''
        auth include login
      '';
    };
  };

  nixpkgs.overlays = [
    (self: super: {
       steam = super.steam.override {
         extraPkgs = pkgs: with pkgs; [
           cups
         ];
       };
#      polkit = super.polkit.overrideAttrs (oldAttrs: {
#        patches = oldAttrs.patches ++ [
#          (super.fetchpatch {
#            url = "https://gitlab.freedesktop.org/polkit/polkit/-/commit/716a273ce0af467968057f3e107156182bd290b0.patch";
#            sha256 = "sha256-hOJJhUmxXm87W1ZU9Y1NJ8GCyKvPjbIVtCHlhRGlN8k=";
#          })];
#      });
    })
  ];

  xdg.mime.defaultApplications = {
    "text/html" = "chromium-browser.desktop";
    "x-scheme-handler/http" = "chromium-browser.desktop";
    "x-scheme-handler/https" = "chromium-browser.desktop";
    "x-scheme-handler/about" = "chromium-browser.desktop";
    "x-scheme-handler/unknown" = "chromium-browser.desktop";
  };

  # environment.sessionsVariables.DEFAULT_BROWSER = "${pkgs.chromium}/bin/chromium";


  boot.supportedFilesystems = [ "kbfs" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

    boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
#  boot.extraModulePackages = [ config.boot.kernelPackages.exfat-nofuse ];  # Broken in nixpkgs; seems to be mountable and usable anyway

  fileSystems."/" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-label/swap"; }
    ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

#  hardware.nvidia.modesetting.enable = true;
#  services.xserver.videoDrivers = [ "nvidia" ];

#  hardware.opentabletdriver.enable = true;

  virtualisation.containerd.enable = true;

  virtualisation.containerd.settings = {
    version = 2;
#    grpc = {
#      uid = 1000;
#    };
  };

  networking.hostName = "python";

  networking.wireless.iwd.enable = true;
  networking.wireless.iwd.settings = {
    Settings = {
      AutoConnect = true;
      AlwaysRandomizeAddress = true;
    };
  };
}
