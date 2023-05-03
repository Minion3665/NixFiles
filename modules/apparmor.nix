{ pkgs, system, username, config, ... }: {
  config = {
    security.apparmor = {
      enable = true;

      packages = [ pkgs.apparmor-profiles ];

      killUnconfinedConfinables = true;

      policies = {
        # TODO: Refactor this into a directory, ideally we'll have too many
        # profiles for this to be just here. Perhaps look at neovim for an
        # example? Explore if we could put these outside of nix files so we can
        # use syntax highlighting

        default_deny = {
          profile = ''
            profile default_deny /** { }
          '';
          enforce = false;
          enable = false;
        };

        sudo = {
          profile = ''
            ${pkgs.sudo}/bin/sudo {
              file /** rwlkUx,
            }
          '';
          enforce = false;
          enable = false;
        };

        nix = {
          profile = ''
            ${pkgs.nix}/bin/nix {
              unconfined,
            }
          '';
          enforce = false;
          enable = false;
        };
      };
    };

    services.dbus.apparmor = "disabled";
  };
}
