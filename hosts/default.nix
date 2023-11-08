{ lib, inputs, nixpkgs, nixpkgs-unstable, home-manager, doom-emacs, hyprland, plasma-manager, vars, ... }:

let 
  system = "x86_64-linux";
     
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  unstable = import nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;
in 
{
  framework = lib.nixosSystem {
    inherit system;
    specialArgs = { 
      inherit inputs system unstable hyprland vars; 
      host = {
        hostName = "framework";
      #  mainMonitor = "HDMI-A-1";
      #  secondMonitor = "HDMI-A-2";
      };
    };
    modules = [ 
      ./configuration.nix
      ./framework
      home-manager.nixosModules.home-manager {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
        #  users.${vars.user} = {
        #    imports = [ ./home.nix ];
        #  };
        };
      }
    ];
  };
};