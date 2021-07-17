{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";
  };
  description = "auto-fix service for vscode remote ssh in NixOS";
  outputs = { self, nixpkgs }: {
    nixosModules = {
      system = import ./modules;
      homeManager = import ./modules/home.nix;
    };
  };
}
