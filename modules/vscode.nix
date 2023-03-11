{ pkgs
, username
, vscode-extensions
, system
, home
, ...
}: {
  home.programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    package = pkgs.vscode-fhs;
    extensions = with vscode-extensions.packages.${system}; [
      vscode.quandinh.onehalf-dark
      pkgs.vscode-extensions.ms-vsliveshare.vsliveshare
      pkgs.vscode-extensions.ms-vscode-remote.remote-ssh
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      /* { */
      /*   name = "codeium"; */
      /*   publisher = "Codeium"; */
      /*   version = "1.1.51"; */
      /*   sha256 = "sha256-MgIRItR2QhGk9U2x+nWjOkUYJxEwYzaKOsxfptpVDaw="; */
      /* } */
    ];
    mutableExtensionsDir = true;
    userSettings = {
      "workbench.colorTheme" = "onehalf-dark";
      "workbench.startupEditor" = "none";
      "files.autoSave" = "afterDelay";
      "files.autoSaveDelay" = 100;
      "editor.lineNumbers" = "relative";
      "extensions.experimental.affinity" = {
        "asvetliakov.vscode-neovim" = 1;
      };
      "vscode-neovim.neovimExecutablePaths.linux" = "${home.programs.neovim.finalPackage}/bin/nvim";
      "security.workspace.trust.enabled" = false;
      "codeium.enableSearch" = true;
    };
  };
  config.internal.allowUnfree = [
    "vscode-extension-ms-vsliveshare-vsliveshare"
    "vscode-extension-ms-vscode-remote-remote-ssh"
    "vscode"
    "vscode-with-extensions"
    "code"
  ];
  config.environment.persistence."/large/persist".users.${username}.directories = [ ".vscode/extensions" ];
}
