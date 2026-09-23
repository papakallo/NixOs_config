{ self, inputs, ... }: {
    flake.nixosModules.desktopManager = { pkgs, lib, ... }: {
        services.desktopManager = {
            plasma6.enable = true;
        };
    };
}
