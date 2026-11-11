{ self, inputs, ...}: {
    flake.homeModules.prismlauncher = { pkgs, lib, ... }:
    {
        programs.prismlauncher = {
            enable = true;
        };

    };

}
