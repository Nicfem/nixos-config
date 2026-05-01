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

      # Optional but recommended to limit the size of your system closure.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";  # важно!
    };
  };

  outputs = { self, nixpkgs, lanzaboote, home-manager, niri, ... }@inputs: let
    system = "x86_64-linux";
    user = "dmitry";
    hostname = "nixos";
    homeStateVersion = "25.11";
  in {
    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
      system = system;
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
            extraSpecialArgs = { inherit homeStateVersion user; };
            users.${user} = import ./home-manager/home.nix;
          };
        }
      ];
    };

    
    # Standalone
    # homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
    #   pkgs = nixpkgs.legacyPackages.${system};
    #   extraSpecialArgs = { 
    #     inherit inputs homeStateVersion user;
    #   };
    #   modules = [ ./home-manager/home.nix ];
    # };
  };
}
