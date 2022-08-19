{ pkgs, ... }: {
    home.packages = [
        pkgs.gtimelog
# pkgs.gtimelog.overrideAttrs(prev: {
        #     src = fetchGit {
        #         url = "git@gitlab.collabora.com:
        #     };
        # })
        pkgs.haskellPackages.arbtt
    ];
}
