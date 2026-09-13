{
    flake.homeModules.swayidle = { pkgs, lib, ... }: {
        services.swayidle.enable = true;
    };
}
