{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs"; # follow the same Nixpkgs input as the rest of their flake. This avoids a second Nixpkgs input and makes Home Manager use the same pinned Nixpkgs source revision as the rest of the configuration. Removes compatibility with home manager lock file
  };

  outputs = { nixpkgs, ... } @ inputs:{
    nixosConfigurations.light = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; }; # allows to pass args to modules, also inherit= inputs=inputs
      modules = [
       ./configuration.nix
     ];
    };

  };
}


