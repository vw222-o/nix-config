{
  description = "A simple NixOS flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
#    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    catppuccin.url = "github:catppuccin/nix";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      plasma-manager,
      catppuccin,
      nix-flatpak,
      stylix,
      ...
    }@inputs:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
#	  determinate.nixosModules.default
          catppuccin.nixosModules.catppuccin
	  stylix.nixosModules.stylix
	  nix-flatpak.nixosModules.nix-flatpak
          home-manager.nixosModules.home-manager
          {
            # other stuffs
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ];
#	    home-manager.backupFileExtension = "hm.OLD";

            home-manager.users.vw222 = {
              imports = [
                ./home.nix
                catppuccin.homeModules.catppuccin
              ];
            };
          }
        ];
      };
    };
}
