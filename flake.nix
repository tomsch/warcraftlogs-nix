{
  description = "Warcraft Logs combat log uploader for NixOS";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      packages.${system} = {
        default = pkgs.callPackage ./package.nix {};
        warcraftlogs = self.packages.${system}.default;
      };

      overlays.default = final: prev: {
        warcraftlogs = final.callPackage ./package.nix {};
      };
    };
}
