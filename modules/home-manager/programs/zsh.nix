{
    flake.homeModules.zsh = { pkgs, lib, ... }: {
        programs.zsh = {
            enable = true;
        };
    };
}
