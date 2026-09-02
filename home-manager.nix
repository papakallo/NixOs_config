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
            # "Ctrl+F3" = "exec pactl set-sink-volume @DEFAULT_SINK@ +1%";
            # "Ctrl+F2" = "exec pactl set-sink-volume @DEFAULT_SINK@ -1%";
            # "Ctrl+F1" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
            "Ctrl+F3" = "exec wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+";
            "Ctrl+F2" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
            "Ctrl+F1" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };
      };
    };

  };
}
