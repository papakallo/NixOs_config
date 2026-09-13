{ self, inputs, ...}: {
    flake.homeModules.packages = { pkgs, lib, ... }:
    {
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
            ddcutil
            findutils
            gawk
            grim
            slurp
            sway-contrib.grimshot
        ];
    };

}
