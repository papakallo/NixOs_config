{ self, inputs, ... }: {
    flake.nixosModules.virtualisation = { pkgs, lib, ... }: {
        virtualisation = {
            virtualbox = {
                host.enable = true;
            };
            docker = {
                enable = true;
                storageDriver = "btrfs"; 
            };
        };

    };
}
