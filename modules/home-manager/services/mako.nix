{ self, inputs, ... }: {
    flake.homeModules.mako = { pkgs, lib, ... }: {
        services.mako = {
            enable = true;
        };
    };
}
