{
  description = "Julien NixOS Config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    helium.url = "github:schembriaiden/helium-browser-nix-flake";
    helium.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    } @ inputs:
    let
      mkHost =
        { hostname }:
        nixpkgs.lib.nixosSystem {
          modules = [ ./hosts/${hostname} ];
          specialArgs = { inherit inputs; };
        };

      mkHome =
        { user, system ? "x86_64-linux" }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [ ./home/${user} ];
          extraSpecialArgs = { inherit inputs; };
        };
    in
    {
      nixosConfigurations = {
        tangerine = mkHost { hostname = "tangerine"; }; # system set by nixpkgs.hostPlatform in hardware-configuration.nix
      };

      homeConfigurations = {
        "julien@tangerine" = mkHome { user = "julien"; };
      };
    };
}
