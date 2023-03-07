{ pkgs
, vscode-extensions
, system
, home
, ...
}: {
  home.programs.vscode = {
    enable = true;
    package = pkgs.vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions.packages.${system}; [
        vscode.quandinh.onehalf-dark
        pkgs.vscode-extensions.ms-vsliveshare.vsliveshare
        pkgs.vscode-extensions.asvetliakov.vscode-neovim
        pkgs.vscode-extensions.ms-vscode-remote.remote-ssh
      ];
    } // {
      pname = "vscode";
    };
    mutableExtensionsDir = false;
    userSettings = {
      "update.channel" = "none";
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
    };
  };
  config.internal.allowUnfree = [
    "vscode-extension-ms-vsliveshare-vsliveshare"
    "vscode-extension-ms-vscode-remote-remote-ssh"
    "vscode"
    "vscode-with-extensions"
  ];
}
