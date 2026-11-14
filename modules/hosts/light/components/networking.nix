{ self, inputs, ... }: {
    flake.nixosModules.networking = { pkgs, lib, ... }: {
        networking = {
            hostName = "light";
            networkmanager.enable = true;
            firewall.enable = true;
            firewall.allowedTCPPorts = [ 8384 ];
        };
    };
}
