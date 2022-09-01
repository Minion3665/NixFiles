{
  pkgs,
  vscode-extensions,
  system,
  ...
}: {
  home.programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with vscode-extensions.packages.${system}; [
      vscode.quandinh.onehalf-dark
      pkgs.vscode-extensions.ms-vsliveshare.vsliveshare
    ];
    mutableExtensionsDir = false;
    userSettings = {
      "update.channel" = "none";
      "workbench.colorTheme" = "onehalf-dark";
      "workbench.startupEditor" = "none";
    };
  };
  config.internal.allowUnfree = ["vscode-extension-ms-vsliveshare-vsliveshare"];
}
