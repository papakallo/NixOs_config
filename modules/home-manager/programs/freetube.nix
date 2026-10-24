{
    flake.homeModules.freetube = { pkgs, lib, ... }: {
        programs.freetube.enable = true;
    };
}
