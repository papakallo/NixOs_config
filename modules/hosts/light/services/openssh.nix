{ self, inputs, ... }: {
    flake.nixosModules.openssh = { pkgs, lib, ... }: {
        services.openssh = {
            enable = true;
            openFirewall = true;
            settings = {
                PasswordAuthentication = false;
                KbdInteractiveAuthentication = false;
                AllowUsers = [ "papakallo" ];
            };
        };
    };
}
