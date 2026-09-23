{ self, inputs, ... }: {
    flake.nixosModules.appimage = { pkgs, lib, ... }: {
        programs.appimage = {
            enable = true;
            binfmt = true;
        };
    };
}
