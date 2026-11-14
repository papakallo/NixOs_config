{ self, inputs, ... }: {
    flake.nixosModules.lightHome = { pkgs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager.useGlobalPkgs = true; # forces Home Manager to use the system's pkgs (which knows about Flake inputs) instead of trying to evaluate import <nixpkgs>
  home-manager.useUserPackages = true; # It installs user packages into /etc/profiles instead of ~/.nix-profile. This keeps your environment cleaner and ties user packages directly to the system generations.


  home-manager.sharedModules = [
        self.homeModules.sway
        self.homeModules.vscodium
        self.homeModules.git
        self.homeModules.waybar
        self.homeModules.swaylock
        self.homeModules.swayidle
        self.homeModules.zsh
        self.homeModules.neovim
        self.homeModules.logseq
        # self.homeModules.qutebrowser
        self.homeModules.mako
        self.homeModules.freetube
        self.homeModules.prismlauncher
  ];


    home-manager.users.papakallo = { config, lib, ... }: {
        home.stateVersion = "26.05";

        home.packages = with pkgs; [
            unzip
            vlc
            obs-studio
            gimp3-with-plugins
            wget
            libreoffice-qt
            hunspell
            hunspellDicts.pl_PL 
            spotify
            openmw
            kdePackages.kate
            telegram-desktop
            discord-ptb
            distrobox
            feh
            kicad
            # nomachine-client
            element-desktop
            ddcutil
            wofi
            findutils
            gawk
            grim
            slurp
            sway-contrib.grimshot

            # Electron Apps do not detect password store
            (symlinkJoin {
                name = "signal-desktop";
                paths = [ signal-desktop ];
                nativeBuildInputs = [ makeWrapper ];
                postBuild = ''
                  wrapProgram $out/bin/signal-desktop \
                    --add-flags "--password-store=kwallet6"
                '';
            })
        ];

    };

};

}
