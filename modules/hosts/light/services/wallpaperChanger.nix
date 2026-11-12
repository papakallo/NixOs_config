{ self, inputs, ... }: {
    flake.nixosModules.wallpaperChanger = { pkgs, lib, ... }: {
        systemd.user.services.wallpaperChanger = {
            name = "wallpaperChanger ";
            enable = true;
            description = "wallpaper changer script for sway";
            after = [ "sway-session.target" ];
            wantedBy = [ "sway-session.target" ];

            # service needs access to sway and bash
            path = [ pkgs.sway pkgs.bash pkgs.coreutils ];
            serviceConfig = {
                Type = "exec";
                ExecStart = ''/home/papakallo/projects/NixOs_config/modules/hosts/light/change_wallpaper.sh'';
                Restart = "no";
            };
        };
    };
}
