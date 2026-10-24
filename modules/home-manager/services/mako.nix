{ self, inputs, ... }: {
    flake.homeModules.mako = { pkgs, lib, ... }: {
        services.mako = {
            enable = true;
            settings = {
                default-timeout=2000;
                anchor="bottom-right";
            };
        };
    };
}
