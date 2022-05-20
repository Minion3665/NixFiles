{ pkgs, ... }: with pkgs; let 
  webstorm = [
    (jetbrains.webstorm.override { jdk = jdk11; })
    nodejs-17_x
    nodePackages.yarn
  ];

  pycharm = [
    (jetbrains.pycharm-professional.override { jdk = jdk11; })
    python310
    python3Packages.numpy
  ];

  rider = [
    jetbrains.rider
    graphviz
    mono
    dotnet-sdk
  ];

  idea = [
    jetbrains.idea-ultimate
  ];

  clion = [
    jetbrains.clion
    platformio
  ];

  goland = [
    jetbrains.goland
  ];
in {
  home.packages = webstorm ++ pycharm ++ rider ++ idea ++ clion ++ goland;
}
