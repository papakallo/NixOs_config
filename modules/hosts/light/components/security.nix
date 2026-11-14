{ self, inputs, ... }: {
    flake.nixosModules.security = { pkgs, lib, ... }: {
        security = {
            # secuirty for sway
            polkit.enable = true;
            pam.services.swaylock = {};

            # allows Pipewire to use the realtime scheduler for increased performance
            rtkit.enable = true;
        };
    };
}
