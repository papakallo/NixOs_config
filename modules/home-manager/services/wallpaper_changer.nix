{ self, inputs, ... }: {
    flake.homeModules.wallpaper_changer = { pkgs, lib, ... }: {
        systemd.user.services.my-cool-user-service = {
          enable = true;
          description = "wallpaper changer script for sway";
          serviceConfig = {
            Type = "simple";
            ExecStart = ''./change_wallpaper.sh'';
          };
        };

    };

}
