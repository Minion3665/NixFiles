{pkgs,...}: {
  config.environment.systemPackages = with pkgs.aspellDicts; [
    pkgs.aspell
    en
    en-computers
    en-science
  ];
}
