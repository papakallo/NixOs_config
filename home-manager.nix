{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.paakallo = {
    /* The home.stateVersion option does not have a default and must be set */
    home.stateVersion = "18.09";
    /* Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ]; */
    
    nixpkgs.config.allowUnfree = true;

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
	
    ];

    programs.git = {
      enable = true;
      userName = "Paakallo";
      userEmail = "paviveerar@gmail.com";
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
	ms-vscode-remote.remote-ssh
	
      ];
    };

  };
}
