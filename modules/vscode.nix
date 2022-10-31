{ pkgs
, vscode-extensions
, system
, home
, ...
}: {
  home.programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with vscode-extensions.packages.${system}; [
      vscode.quandinh.onehalf-dark
      pkgs.vscode-extensions.ms-vsliveshare.vsliveshare
      pkgs.vscode-extensions.asvetliakov.vscode-neovim
    ];
    mutableExtensionsDir = false;
    userSettings = {
      "update.channel" = "none";
      "workbench.colorTheme" = "onehalf-dark";
      "workbench.startupEditor" = "none";
      "files.autoSave" = "afterDelay";
      "files.autoSaveDelay" = 100;
      "extensions.experimental.affinity" = {
        "asvetliakov.vscode-neovim" = 1;
      };
      "vscode-neovim.neovimExecutablePaths.linux" = "${home.programs.neovim.finalPackage}/bin/nvim";
    };
  };
  config.internal.allowUnfree = [ "vscode-extension-ms-vsliveshare-vsliveshare" ];
}
