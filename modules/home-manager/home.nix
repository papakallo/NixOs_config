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
        self.homeModules.packages
        self.homeModules.vscodium
        self.homeModules.git
        self.homeModules.waybar
        self.homeModules.swaylock
        self.homeModules.swayidle
        self.homeModules.zsh
        self.homeModules.neovim
        self.homeModules.logseq
  ];


  home-manager.users.papakallo = { config, lib, ... }: {
    home.stateVersion = "26.05";

    };

};

}
