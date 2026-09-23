{ self, inputs, ... }: {
    flake.nixosModules.xserver = { pkgs, lib, ... }: {
        services.xserver = {
            # Configure keymap in X11
            xkb = {
                layout = "pl,ru,ua,de";
                variant = "";
            };
        };
    };
}
