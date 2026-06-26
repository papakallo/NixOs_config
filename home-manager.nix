{ config, pkgs, inputs, ... }:
  # Create a customized version of logseq
#  logseq-patch = pkgs.logseq.override {
#    electron_27 = pkgs.electron_34;
#  };
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager.useGlobalPkgs = true; # forces Home Manager to use the system's pkgs (which knows about your Flake inputs) instead of trying to evaluate import <nixpkgs>
  home-manager.useUserPackages = true; # It installs user packages into /etc/profiles instead of ~/.nix-profile. This keeps your environment cleaner and ties user packages directly to the system generations.

  home-manager.users.papakallo = {
    /* The home.stateVersion option does not have a default and must be set */
    home.stateVersion = "26.05";
    /* Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ]; */
    
    home.packages = [
      pkgs.unzip
      pkgs.vlc
      pkgs.obs-studio
      pkgs.gimp3-with-plugins
      pkgs.wget
      pkgs.vscode
      pkgs.libreoffice-qt
      pkgs.hunspell
      pkgs.hunspellDicts.pl_PL 
      pkgs.spotify
      pkgs.dosbox-staging
#      logseq-patch	
#      pkgs.logseq
      pkgs.openmw
    ];

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
      #extraConfig = ''
      #  set number relativenumber
      #  '';
   };

  };
}
