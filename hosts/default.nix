{ lib, inputs, nixpkgs, nixpkgs-stable, nixos-hardware, home-manager, nixvim, hyprland, vars, impermanence, disko, lanzaboote, ... }:

let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  stable = import nixpkgs-stable {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;
in
{
  framework = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs system stable hyprland vars;
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
      nixvim.nixosModules.nixvim
      impermanence.nixosModules.impermanence
      disko.nixosModules.disko
      lanzaboote.nixosModules.lanzaboote
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
  server = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs system stable hyprland vars;
      host = {
        hostName = "server";
      };
    };
    modules = [
      ./configuration.nix
      ./server
      nixvim.nixosModules.nixvim
      impermanence.nixosModules.impermanence
      disko.nixosModules.disko
      lanzaboote.nixosModules.lanzaboote
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
  nuc = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs system stable hyprland vars;
      host = {
        hostName = "nuc";
        #mainMonitor = "HDMI-A-1";
      };
    };
    modules = [
      ./configuration.nix
      ./nuc
      nixvim.nixosModules.nixvim
      impermanence.nixosModules.impermanence
      disko.nixosModules.disko
      lanzaboote.nixosModules.lanzaboote
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
  vm = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs system stable hyprland vars;
      host = {
        hostName = "nixos-vm";
      };
    };
    modules = [
      ./configuration.nix
      ./vm
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
