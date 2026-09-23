{ self, inputs, ... }: {
    flake.nixosModules.displayManager = { pkgs, lib, ... }: {
        services.displayManager = {
            # turn on a login program and session manager
            sddm.enable = true;
        };
    };
}
