{ self, inputs, ...}: {
    flake.homeModules.logseq = { pkgs, lib, ... }:
    let
      # Create a customized version of logseq
      logseq-patch = pkgs.logseq.override {
        electron_39 = pkgs.electron_41;
      };
    in
    {
        home.packages = [
            logseq-patch
        ];
    };
}
