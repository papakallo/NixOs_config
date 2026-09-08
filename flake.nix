{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs"; # follow the same Nixpkgs input as the rest of their flake. This avoids a second Nixpkgs input and makes Home Manager use the same pinned Nixpkgs source revision as the rest of the configuration. Removes compatibility with home manager lock file

    nvim-config.url = "github:papakallo/kickstart.nvim?ref=master";
    nvim-config.flake = false;

  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} (inputs.import-tree ./modules);
}
