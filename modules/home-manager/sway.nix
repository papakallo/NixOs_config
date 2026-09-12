{ self, inputs, ... }: {
    flake.homeModules.sway = { pkgs, lib, ... }: {
        # programs.sway = {
        wayland.windowManager.sway = {
            enable = true;

            wrapperFeatures.gtk = true; # Fixes common issues with GTK 3 apps
            config = rec {
              modifier = "Mod4";
              terminal = "kitty";
              # startup = [
              #   # Launch Firefox on start
              #   { command = "firefox"; }
              # ];
              input = {
                  "type:touchpad" = {
                      # Enables or disables tap for specified input device.
                      tap = "enabled";
                      # Enables or disables natural (inverted) scrolling for the specified input device.
                      natural_scroll = "enabled";
                      # Enables or disables disable-while-typing for the specified input device.
                      dwt = "enabled";
                  };
              };

              keybindings = {
                  # Brightness Controls
                  "Ctrl+F7" = "exec brightnessctl set 5%-";
                  "Ctrl+F8" = "exec brightnessctl set 5%+";

                  # Volume Controls
                  "Ctrl+F3" = "exec wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+";
                  "Ctrl+F2" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
                  "Ctrl+F1" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

                  # Movements
                  "Mod4+0" = "workspace number 10";
                  "Mod4+1" = "workspace number 1";
                  "Mod4+2" = "workspace number 2";
                  "Mod4+3" = "workspace number 3";
                  "Mod4+4" = "workspace number 4";
                  "Mod4+5" = "workspace number 5";
                  "Mod4+6" = "workspace number 6";
                  "Mod4+7" = "workspace number 7";
                  "Mod4+8" = "workspace number 8";
                  "Mod4+9" = "workspace number 9";

                  # Focus
                  # Arrow Motions
                  "Mod4+Down" = "focus down";
                  "Mod4+Left" = "focus left";
                  "Mod4+Right" = "focus right";
                  "Mod4+Up" = "focus up";
                  # Vim Motions
                  "Mod4+h" = "focus left";
                  "Mod4+j" = "focus down";
                  "Mod4+k" = "focus up";
                  "Mod4+l" = "focus right";
                  # Other
                  "Mod4+a" = "focus parent";
                  "Mod4+space" = "focus mode_toggle";

                  "Mod4+r" = "mode resize";

                  # Terminal
                  "Mod4+Home" = "exec kitty";

                  # move window to other workspace
                  "Mod4+Shift+0" = "move container to workspace number 10";
                  "Mod4+Shift+1" = "move container to workspace number 1";
                  "Mod4+Shift+2" = "move container to workspace number 2";
                  "Mod4+Shift+3" = "move container to workspace number 3";
                  "Mod4+Shift+4" = "move container to workspace number 4";
                  "Mod4+Shift+5" = "move container to workspace number 5";
                  "Mod4+Shift+6" = "move container to workspace number 6";
                  "Mod4+Shift+7" = "move container to workspace number 7";
                  "Mod4+Shift+8" = "move container to workspace number 8";
                  "Mod4+Shift+9" = "move container to workspace number 9";

                  # Move Windows in a certain direction
                  # Keyboard Motions
                  "Mod4+Shift+Down" = "move down";
                  "Mod4+Shift+Left" = "move left";
                  "Mod4+Shift+Right" = "move right";
                  "Mod4+Shift+Up" = "move up";
                  # Vim Motions
                  "Mod4+Shift+h" = "move left";
                  "Mod4+Shift+j" = "move down";
                  "Mod4+Shift+k" = "move up";
                  "Mod4+Shift+l" = "move right";
                  "Mod4+Shift+minus" = " move scratchpad";

                  # Window Options
                  "Mod4+Shift+q" = "kill";
                  "Mod4+Shift+c" = "reload";

                  # Lock Screen
                  "Ctrl+Shift+l" = "exec swaylock -f";

                  # PowerOff
                  "Mod4+c+h+u+j" = "exec poweroff";

                  "Mod4+Shift+space" = "floating toggle";

                  # Split Options
                  "Mod4+b" = "splith";
                  "Mod4+v" = "splitv";

                  "Mod4+e" = "exec /nix/store/5llj78qhx10ldhglkss48bqa4yjs66ra-dmenu-5.4/bin/dmenu_path | /nix/store/5llj78qhx10ldhglkss48bqa4yjs66ra-dmenu-5.4/bin/dmenu | /nix/store/ibg16grw5is7i7ilnflc5xmj6fwksqkl-findutils-4.11.0/bin/xargs swaymsg exec --";

                  # Layout Controls
                  "Mod4+d" = "layout toggle split";
                  "Mod4+w" = "layout tabbed";
                  "Mod4+s" = "layout stacking";

                  "Mod4+f" = "fullscreen toggle";

                  "Mod4+minus" = "scratchpad show";

                  # Super + Shift + S
                  # Screenshot a selection that saves to ~/Screenshots and copies to clipboard.
                  "Mod4+Shift+s" = "exec selection=$(slurp) && grim -g \"$selection\" - | tee ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png | wl-copy";

                  # Print Screen Button
                  # Screenshot the currently focused screen, save to ~/Screenshots and copy to clipboard.
                  "Print" = "exec grimshot save output - | tee ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png | wl-copy";

            };

        };
        # Automatic lock and sleep
        extraConfig = ''
            exec_always "killall -q swayidle; ${pkgs.swayidle}/bin/swayidle -w \
            timeout 120 '${pkgs.ddcutil}/bin/ddcutil detect | ${pkgs.gawk}/bin/awk \"/Display/ {print \\$2}\" | ${pkgs.findutils}/bin/xargs -I{} ${pkgs.ddcutil}/bin/ddcutil setvcp 10 30 --display {}' \
            resume '${pkgs.ddcutil}/bin/ddcutil detect | ${pkgs.gawk}/bin/awk \"/Display/ {print \\$2}\" | ${pkgs.findutils}/bin/xargs -I{} ${pkgs.ddcutil}/bin/ddcutil setvcp 10 100 --display {}' \
            timeout 240 '${pkgs.swaylock}/bin/swaylock -f' \
            timeout 300 '${pkgs.sway}/bin/swaymsg \"output * dpms off\"' \
            resume '${pkgs.sway}/bin/swaymsg \"output * dpms on\"' \
            timeout 1800 'systemctl suspend' \
            before-sleep '${pkgs.swaylock}/bin/swaylock -f'"
        '';

        };
    };

        # };
    # };

}
