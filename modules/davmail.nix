{ pkgs, ... }: {
  home.home = {
    packages = [ pkgs.davmail ];
    file.".davmail.properties".text = ''
      davmail.server=true
      davmail.mode=EWS
      davmail.url=https://outlook.office365.com/EWS/Exchange.asmx

      davmail.imapPort=1143
      davmail.smtpPort=1025
    '';
  };
}
