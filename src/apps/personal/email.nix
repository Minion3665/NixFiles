{ pkgs, ... }: {
    accounts.email.accounts = {
        collabora = {
            astroid = {
                enable = true;
                sendMailCommand = "${pkgs.msmtp}/bin/msmtpq --read-envelope-from --read-recipients";
            };
            msmtp.enable = true;
            himalaya.enable = true;
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
            passwordCommand = "${pkgs.coreutils}/bin/cat /run/secrets/collabora-password";
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
        extraConfig = ''
        auto_view text/html
        '';
    };
    programs.notmuch.enable = true;
    home.packages = [ pkgs.lynx ];
    home.file.".mailcap".text = ''
    text/html; ${pkgs.lynx}/bin/lynx -force_html -dump %s; copiousoutput
    '';
}
