{ self, inputs, ... }: {
    flake.nixosModules.syncthing = { pkgs, lib, ... }: {
        #TODO: make syncthing more declarative
        services.syncthing = {
            enable = true;
            group = "syncthing";
            user = "papakallo";
            dataDir = "/home/papakallo/Documents";
            configDir = "/home/papakallo/.config/syncthing";
            openDefaultPorts = true;
        };
    };
}
