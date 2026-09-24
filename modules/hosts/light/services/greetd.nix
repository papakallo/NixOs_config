{ self, inputs, ... }: {
    flake.nixosModules.greetd = { pkgs, lib, ... }:
    let
        swayConfig = pkgs.writeText "greetd-sway-config" ''
            # `-l` activates layer-shell mode. Notice that `swaymsg exit` will run after gtkgreet.
            exec "${pkgs.gtkgreet}/bin/gtkgreet -l; swaymsg exit"
            bindsym Mod4+shift+e exec swaynag \
                -t warning \
                -m 'What do you want to do?' \
                -b 'Poweroff' 'systemctl poweroff' \
                -b 'Reboot' 'systemctl reboot'
        '';
    in
    {
        # services.greetd = {
        #     enable = true;
        #     settings = {
        #         default_session = {
        #             # command = "${pkgs.sway}/bin/sway --config ${swayConfig}";
        #             command = "${pkgs.regreet}/bin/regreet";
        #             user = "papakallo";
        #         };
        #     };
        # };

        # Manually publish the Wayland session file to the system path
        services.displayManager.sessionPackages = [ pkgs.sway ];
        environment.etc."greetd/environments".text = ''
            sway
            bash
            startplasma-wayland
        '';
    };
}
