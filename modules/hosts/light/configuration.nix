{ self, inputs, ... }: {

  flake.nixosModules.lightConfiguration = { pkgs, lib, ... }:
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

    imports = [
      self.nixosModules.lightHardware
      self.nixosModules.lightHome
      self.nixosModules.lightNvidia
      self.nixosModules.printing
      self.nixosModules.xserver
      self.nixosModules.displayManager
      self.nixosModules.desktopManager
      self.nixosModules.avahi
      self.nixosModules.syncthing
      self.nixosModules.tailscale
      self.nixosModules.pipewire
      self.nixosModules.flatpak
      self.nixosModules.openssh
      self.nixosModules.networking
    ];

    services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.sway}/bin/sway --config ${swayConfig}";
      };
    };
  };

  environment.etc."greetd/environments".text = ''
    sway
    bash
    startplasma-wayland
  '';

  # Bootloader.
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev"; # "nodev" is used for UEFI
      efiSupport = true;
    };
    efi.canTouchEfiVariables = true;
  };


  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  hardware.bluetooth.enable = true;

  # enable I2C for monitors
  hardware.i2c.enable = true;

  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = ["all"];
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  # secuirty for sway
  security.polkit.enable = true;
  security.pam.services.swaylock = {};


  # xdg portal + pipewire = screensharing
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  security.rtkit.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.papakallo = {
    isNormalUser = true;
    description = "Papakallo";
    extraGroups = [ "networkmanager" "wheel" "docker" "video" ];
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     vim
     git
     gh
     brightnessctl
     lshw
   ];


  programs.firefox.enable = true;

  programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      gamescopeSession.enable = true;
    };


 # virtualbox
 virtualisation.virtualbox.host.enable = true;
 users.extraGroups.vboxusers.members = [ "papakallo" ];

 #docker
 virtualisation.docker.enable = true;
 virtualisation.docker.storageDriver = "btrfs"; 


 programs.appimage.enable = true;
 programs.appimage.binfmt = true;


 programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
        stdenv.cc.cc
        zlib
        glibc
        openssl
    ];
 };

programs.zsh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?



  };

}
