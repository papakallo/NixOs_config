{ self, inputs, ... }: {
  flake.nixosModules.lightConfiguration = { pkgs, lib, ... }: {
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
      self.nixosModules.appimage
      self.nixosModules.firefox
      self.nixosModules.steam
      self.nixosModules.nix-ld
      self.nixosModules.zsh
      self.nixosModules.greetd
      self.nixosModules.security
      self.nixosModules.virtualisation
    ];

  # Bootloader
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


  # xdg portal + pipewire = screensharing
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  users.users.papakallo = {
    isNormalUser = true;
    description = "Papakallo";
    extraGroups = [ "networkmanager" "wheel" "docker" "video" ];
  };
  users.extraGroups.vboxusers.members = [ "papakallo" ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
     vim
     git
     gh
     brightnessctl
     lshw
   ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
  };

}
