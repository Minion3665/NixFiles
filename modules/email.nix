{ pkgs
, config
, username
, home
, lib
, ...
}: {
  home = {
    accounts.email = {
      maildirBasePath = "Mail";
      accounts = {
        collabora = {
          astroid = {
            enable = true;
            sendMailCommand = "${pkgs.msmtp}/bin/msmtpq --read-envelope-from --read-recipients";
          };
          msmtp.enable = true;
          aerc = {
            enable = true;
            extraAccounts = {
              source = "notmuch://~/${home.accounts.email.maildirBasePath}/collabora";
            };
          };
          himalaya = {
            enable = true;
            backend = "imap";
            sender = "smtp";
          };
          neomutt.enable = true;
          mbsync = {
            enable = true;
            create = "maildir";
          };
          notmuch.enable = true;
          address = "skyler.grey@collabora.com";
          imap = {
            host = "mail.collabora.com";
            port = 143;
            tls.useStartTls = true;
          };
          smtp = {
            host = "mail.collabora.com";
            port = 587;
            tls.useStartTls = true;
          };
          userName = "skyler";
          realName = "Skyler Grey";
          primary = true;
          signature = {
            showSignature = "append";
            text = ''
              Miss Skyler Grey
              Intern

              Collabora Ltd.
              Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
              Registered in England & Wales, no. 5513718'';
          };
          passwordCommand = "${pkgs.coreutils}/bin/cat ${config.sops.secrets.collaboraPassword.path}";
        };
      };
    };
    programs.astroid.enable = true;
    programs.msmtp.enable = true;
    services.mbsync = {
      enable = true;
      postExec = "${pkgs.notmuch}/bin/notmuch new";
    };
    programs.mbsync.enable = true;
    programs.himalaya.enable = true;
    programs.neomutt = {
      enable = true;
      sidebar.enable = true;
      settings = {
        preferred_languages = "en";
      };
      vimKeys = true;
      extraConfig = ''
        auto_view text/html

        set virtual_spoolfile = yes

        unmailboxes *
        virtual-mailboxes "Inbox" "notmuch://?query=tag:inbox and not tag:deleted"
        virtual-mailboxes "Unread" "notmuch://?query=tag:unread and tag:inbox and not tag:deleted&type=threads"
        virtual-mailboxes "Trash" "notmuch://?query=tag:deleted"

        bind pager,index l modify-tags
        
        shutdown-hook "source ${./email/notmuch-new-retag.sh}|"
        folder-hook ".*" "source ${./email/notmuch-new-retag.sh}|"

        source ${./email/neomutt-theme.muttrc}
      '';
    };
    programs.notmuch = {
      enable = true;
      new.tags = [ "unread" "new" ];
      hooks.postNew = builtins.readFile ./email/notmuch-new-retag.sh;
    };
    programs.aerc = {
      enable = true;
      extraConfig.general.unsafe-accounts-conf = true;
      extraBinds = lib.pipe ./email/aerc-default-binds.toml [ builtins.readFile builtins.fromTOML ];
      extraConfig.filters =
        let
          defaultFilters = lib.pipe "${pkgs.aerc}/share/aerc/filters" [
            builtins.readDir
            builtins.attrNames
            (builtins.map (f: {
              name = f;
              value = "${pkgs.aerc}/share/aerc/filters/${f}";
            }))
            builtins.listToAttrs
          ];
        in
        with defaultFilters; {
          "text/plain" = colorize;
          "text/calendar" = defaultFilters."show-ics-details.py";
          "text/html" = html;
        };
    };
    home.packages = with pkgs; [ lynx ];
    home.file.".mailcap".text = ''
      text/html; ${pkgs.lynx}/bin/lynx -force_html -dump %s; copiousoutput
      image/*; ${pkgs.kitty}/bin/kitty +kitten icat && read -r -n1 key
    '';
    home.file.".config/neomutt/themes/one-half-dark.muttrc".text =
      builtins.readFile ./email/neomutt-theme.muttrc;
    home.shellAliases = {
      mutt = "${pkgs.neomutt}/bin/neomutt";
    };
  };
  config = {
    sops.secrets.collaboraPassword = {
      mode = "0400";
      owner = config.users.users.${username}.name;
      group = config.users.users.nobody.group;
    };
    environment.persistence."/nix/persist".users.${username}.directories = [ "Mail" ];
  };
}
