{ pkgs, ... }: {
    home.packages = [
        pkgs.bazel_5
    ];

    home.shellAliases = {
        build = "${pkgs.bazel_5}/bin/bazel build";
    };
}
