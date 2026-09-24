{ self, inputs, ... }: {
    flake.nixosModules.regreet = { pkgs, lib, ... }: {
        # export sway, so regreet would see it
        services.displayManager.sessionPackages = [ pkgs.sway ];
        programs.regreet = {
            enable = true;
            theme = {
                name = "Adwaita-dark";
                package = pkgs.gnome-themes-extra;
            };

            cursorTheme = {
                name = "Adwaita";
                package = pkgs.adwaita-icon-theme;
            };

            iconTheme = {
                name = "Adwaita";
                package = pkgs.adwaita-icon-theme;
            };

            font = {
                name = "Cantarell";
                package = pkgs.cantarell-fonts;
                size = 14;
            };

            settings = {
                background = {
                    path = "/home/papakallo/Pictures/wallpapers/Asuka_Deutschland.png";
                    fit = "Cover";
                };
                commands = {
                    default_session = "Sway";
                };
            };
        };
    };
}
