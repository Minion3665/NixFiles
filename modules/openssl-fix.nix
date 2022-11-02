{pkgs, nixpkgs-staging-next, ...}: {
  config.system.replaceRuntimeDependencies = [
    ({
      original = pkgs.openssl;
      replacement = nixpkgs-staging-next.legacyPackages.x86_64-linux.openssl_3;
    })
  ];
  home.home.packages = [pkgs.openssl];
}
