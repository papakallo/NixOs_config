{ self, inputs, ... }: {
    flake.nixosModules.avahi = { pkgs, lib, ... }: {
        services.avahi = {
            enable = true;
            nssmdns4 = true;
            openFirewall = true;
        };
    };
}
