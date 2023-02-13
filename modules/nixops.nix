{ pkgs, ... }: {
  home.home.packages = [ pkgs.nixops ];
  config.nixpkgs.config.permittedInsecurePackages = [
    "python-2.7.18.6"
    "python2.7-certifi-2021.10.8"
    "python2.7-pyjwt-1.7.1"
  ];
}
