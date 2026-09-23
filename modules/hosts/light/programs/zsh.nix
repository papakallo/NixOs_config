{ self, inputs, ... }: {
    flake.nixosModules.zsh = { pkgs, lib, ... }: {
        programs.zsh = {
            enable = true;
        };
    };
}
