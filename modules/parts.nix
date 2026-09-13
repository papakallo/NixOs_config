{ lib, ...}: {
    options.flake.homeModules = lib.mkOption {
        type = lib.types.lazyAttrsOf lib.types.raw;
        default = {};
        description = "Home Manager modules";
    };
    config = {
        systems = [
            "x86_64-linux"
            "x86_64-darwin"
            "aarch64-linux"
            "aarch64-darwin"
        ];
  };
}
