{
  description = "A very basic flake";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable"; 
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixgl = {                                                             # Fixes OpenGL With Other Distros.
      url = "github:guibou/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {                                                          # Official Hyprland Flake
      url = "github:hyprwm/Hyprland";                                     # Requires "hyprland.nixosModules.default" to be added the host modules
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    grub2-themes = {
      url = "github:vinceliuice/grub2-themes";
    };
  };

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, nixos-hardware, home-manager, nixvim, nixgl, hyprland, grub2-themes, ...}: 
    let 
      vars = {                                                              # Variables Used In Flake
        user = "jan";
        location = "$HOME/.setup";
        terminal = "kitty";
        editor = "nvim";
      };
    in 
    {
      nixosConfigurations = (                                               # NixOS Configurations
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs nixpkgs-unstable nixos-hardware home-manager nixvim hyprland vars grub2-themes; 
        }
      );
        
      homeConfigurations = (                                                # Nix Configurations
        import ./nix {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs nixpkgs-unstable home-manager nixvim vars;
        }
      );
      
    };
}
