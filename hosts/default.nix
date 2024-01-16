{ lib, inputs, nixpkgs, nixpkgs-unstable, nixos-hardware, home-manager, hyprland, plasma-manager, vars, grub2-themes, ... }:

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
        mainMonitor = "eDP-1";
        secondMonitor = "DP-11";
        thirdMonitor = "DP-9";
      };
    };
    modules = [ 
      ./configuration.nix
      ./framework
      nixos-hardware.nixosModules.framework-13-7040-amd
      grub2-themes.nixosModules.default
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
}
