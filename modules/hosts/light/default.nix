{ self, inputs, ... }: {
  flake.nixosConfigurations.light = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit self inputs; };
    modules = [
      self.nixosModules.lightConfiguration
    ];
  };
}
