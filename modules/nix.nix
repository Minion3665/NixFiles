{
  pkgs,
  registry,
  ...
}: {
  config = {
    nix = {
      settings = {
        experimental-features = ["nix-command" "flakes"];
        auto-optimise-store = true;
        keep-outputs = true;
        flake-registry = "${registry}/flake-registry.json";
      };
      gc = {
        automatic = true;
        options = "--delete-older-than 7d";
      };
    };
  };
}
