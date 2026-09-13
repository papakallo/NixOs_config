{ self, inputs, ...}: {
    flake.homeModules.neovim = { pkgs, lib, ... }: {
        programs.neovim = {
            enable = true;
        };
        xdg.configFile."nvim".source = "${inputs.nvim-config}";
    };
}
