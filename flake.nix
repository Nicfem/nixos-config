{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tmux = {
      url = "github:Nicfem/tmux/nixos";
      flake = false;
    };

    ags = {
      url = "github:Nicfem/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tweakcc = {
      url = "github:Nicfem/tweakcc";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, lanzaboote, home-manager, niri, ... }@inputs: let
    system = "x86_64-linux";
    user = "dmitry";
    hostname = "nixos";
    homeStateVersion = "25.11";
  in {
    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs homeStateVersion hostname user;
      };
      modules = [ 
        lanzaboote.nixosModules.lanzaboote
        niri.nixosModules.niri
        ./nix-os/configuration.nix 

        # Module
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
            extraSpecialArgs = { inherit inputs homeStateVersion user; };
            users.${user} = import ./home-manager/home.nix;
          };
        }
      ];
    };
  };
}
