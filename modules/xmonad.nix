{pkgs, ...}: {
  home.xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    config = ./xmonad/xmonad.hs;
    extraPackages = haskellPackages: with haskellPackages; [
      taffybar
    ];
  };
}
