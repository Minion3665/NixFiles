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
          enable = true;
        };

        sudo = {
          profile = ''
          ${config.security.wrapperDir}/sudo {
            file rwlkUx,
          }
          '';
        };
      };
    };

    services.dbus.apparmor = "required";
  };
}
