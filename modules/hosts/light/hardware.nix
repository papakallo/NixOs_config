{ self, inputs, ... }: {

  flake.nixosModules.lightHardware = { config, lib, pkgs, modulesPath, ... }: {
    imports =
      [ (modulesPath + "/installer/scan/not-detected.nix")
      ];

    boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" =
      { device = "/dev/mapper/luks-3fc5e772-d840-4bdc-a4c7-e6fa55c73f27";
        fsType = "btrfs";
      };

    boot.initrd.luks.devices."luks-3fc5e772-d840-4bdc-a4c7-e6fa55c73f27".device = "/dev/disk/by-uuid/3fc5e772-d840-4bdc-a4c7-e6fa55c73f27";

    fileSystems."/home" =
      { device = "/dev/mapper/luks-3fc5e772-d840-4bdc-a4c7-e6fa55c73f27";
        fsType = "btrfs";
        options = [ "subvol=home" ];
      };

    fileSystems."/nix" =
      { device = "/dev/mapper/luks-3fc5e772-d840-4bdc-a4c7-e6fa55c73f27";
        fsType = "btrfs";
        options = [ "subvol=nix" ];
      };

    fileSystems."/boot" =
      { device = "/dev/disk/by-uuid/8FF2-679A";
        fsType = "vfat";
        options = [ "fmask=0077" "dmask=0077" ];
      };

    swapDevices =
      [ { device = "/dev/mapper/luks-97eaab1a-229e-4d02-9a2f-202a31ad8595"; }
      ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };

}
