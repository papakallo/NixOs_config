{ self, inputs, ... }: {
  flake.nixosConfigurations.light = inputs.nixpkgs.lib.nixosSystem {
    # self = self, inputs = inputs; this way all modules have access to the inputs and self
    specialArgs = { inherit self inputs; };
    modules = [
      self.nixosModules.lightConfiguration
    ];
  };
}
