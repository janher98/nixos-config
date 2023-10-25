{
  description = "A very basic flake";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }: 

    let 
      system = "x86_64-linux";
      user = "jan";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        ${user} = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit user; };
          modules = [ 
            ./configuration.nix 
            home-manager.nixosModules.home-manager {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${user} = {
                  imports = [ ./home.nix ];
                };
              };
            }
          ];
        };
        # other = lib.nixosSystem {
        #   inherit system;
        #   modules = [ ./otherconfiguration.nix];
        # };
        # hmConfig = {
        #   jan = home-manager.lib.homeManagerConfiguration {
        #     inherit system pkgs;
        #     username = "jan";
        #     homeDirectory = "/home/jan";
        #     configuration = {
        #       imports = [
        #         ./home.nix
        #       ];
        #     };
        #   };
        # };
      };
    };
}
