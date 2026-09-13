{
    flake.homeModules.waybar = { pkgs, lib, ... }: {
        programs.waybar.enable = true;
    };
}
