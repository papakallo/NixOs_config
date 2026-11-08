{ self, inputs, ... }: {
    flake.nixosModules.zerotierone = { pkgs, lib, ... }: {
services.zerotierone = {
  enable = true;
  joinNetworks = [
    "d5e5fb653774a84a"
  ];
};    };
}
