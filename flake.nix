{
  description = "simple file manager";
  inputs.nixpkgs.follows = "nix/nixpkgs";
  outputs = { self, nix, nixpkgs, ... }: {

    overlays.sfm = import ./overlay.nix;
    overlay = self.overlays.sfm;

    packages.x86_64-linux.sfm = ( import nixpkgs {
      sys = "x86_64-linux";
      overlays = [self.overlay nix.overlay];
    } ).sfm;
    defaultPackage.x86_64-linux = self.packages.x86_64-linux.sfm;

    nixosModules.sfm = { pkgs, ... }: {
      nixpkgs.overlays = [self.overlay];
    };
    nixosModule = self.nixosModules.sfm;
  };
}
