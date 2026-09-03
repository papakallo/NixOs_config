{ config, pkgs, inputs, ... }:
  # Create a customized version of logseq
#  logseq-patch = pkgs.logseq.override {
#    electron_27 = pkgs.electron_34;
#  };
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager.useGlobalPkgs = true; # forces Home Manager to use the system's pkgs (which knows about Flake inputs) instead of trying to evaluate import <nixpkgs>
  home-manager.useUserPackages = true; # It installs user packages into /etc/profiles instead of ~/.nix-profile. This keeps your environment cleaner and ties user packages directly to the system generations.


  home-manager.users.papakallo = { config, lib, ... }: {
    /* The home.stateVersion option does not have a default and must be set */
    home.stateVersion = "26.05";
    /* Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ]; */
    
    home.packages = with pkgs; [
      unzip
      vlc
      obs-studio
      gimp3-with-plugins
      wget
      vscode
      libreoffice-qt
      hunspell
      hunspellDicts.pl_PL 
      spotify
      dosbox-staging
      openmw
      kdePackages.kate
      telegram-desktop
      discord-ptb
      distrobox
      atlauncher
      feh
      kicad
      # temporarily removed, because the branch is very unstable
      # freecad
      nomachine-client
      signal-desktop
      element-desktop
      kitty
    ];

    programs.zsh = {
        enable = true;
    };

    programs.git = {
      enable = true;
      settings.user.name = "papakallo";
      settings.user.email = "paviveerar@gmail.com";
    };

    programs.vscode = {
      enable = true;
      profiles.default.extensions = with pkgs.vscode-extensions; [
        dracula-theme.theme-dracula
        vscodevim.vim
        yzhang.markdown-all-in-one
	zainchen.json
        ms-python.python
        ms-python.debugpy
	ms-vscode.cpptools
	ms-vscode.cmake-tools
#        ms-vscode.cpptools-themes
	ms-vscode-remote.remote-ssh
	
      ];
    };

    programs.neovim = {
      enable = true;
   };

    xdg.configFile."nvim".source = "${inputs.nvim-config}";

    # ricing
    programs.waybar.enable = true;

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
            "Mod4+Down" = "focus down";
            "Mod4+Left" = "focus left";
            "Mod4+Return" = "exec kitty";
            "Mod4+Right" = "focus right";
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
            "Mod4+Shift+Down" = "move down";
            "Mod4+Shift+Left" = "move left";
            "Mod4+Shift+Right" = "move right";
            "Mod4+Shift+Up" = "move up";
            "Mod4+Shift+c" = "reload";
            "Mod4+Shift+e" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";
            "Mod4+Shift+h" = "move left";
            "Mod4+Shift+j" = "move down";
            "Mod4+Shift+k" = "move up";
            "Mod4+Shift+l" = "move right";
            "Mod4+Shift+minus" = " move scratchpad";
            "Mod4+Shift+q" = "kill";
            "Mod4+Shift+space" = "floating toggle";
            "Mod4+Up" = "focus up";
            "Mod4+a" = "focus parent";
            "Mod4+b" = "splith";
            "Mod4+d" = "exec /nix/store/5llj78qhx10ldhglkss48bqa4yjs66ra-dmenu-5.4/bin/dmenu_path | /nix/store/5llj78qhx10ldhglkss48bqa4yjs66ra-dmenu-5.4/bin/dmenu | /nix/store/ibg16grw5is7i7ilnflc5xmj6fwksqkl-findutils-4.11.0/bin/xargs swaymsg exec --";
            "Mod4+e" = "layout toggle split";
            "Mod4+f" = "fullscreen toggle";
            "Mod4+h" = "focus left";
            "Mod4+j" = "focus down";
            "Mod4+k" = "focus up";
            "Mod4+l" = "focus right";
            "Mod4+minus" = "scratchpad show";
            "Mod4+r" = "mode resize";
            "Mod4+s" = "layout stacking";
            "Mod4+space" = "focus mode_toggle";
            "Mod4+v" = "splitv";
            "Mod4+w" = "layout tabbed";

};

};

};

};


}
