{ self, inputs, ...}: {
    flake.homeModules.qutebrowser = { pkgs, lib, ... }: {
        programs.qutebrowser = {
            enable = true;
        };
    };
}
