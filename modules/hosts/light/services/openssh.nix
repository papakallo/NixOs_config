{ self, inputs, ... }: {
    flake.nixosModules.openssh = { pkgs, lib, ... }: {
        services.openssh = {
            enable = true;
        };
    };
}
