{ lib, inputs, nixpkgs, home-manager, vars, ... }:

let
  system = "x86_64-linux";                                  # System Architecture
  pkgs = nixpkgs.legacyPackages.${system};
in
{
  "cli" = home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
#    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    extraSpecialArgs = { inherit inputs vars; };
    modules = [   #
      ./home.nix
      #../modules/editors/nvim.nix
      #../modules/programs/kitty.nix
      {
        home = {
          username = "${vars.user}";
          homeDirectory = "/home/${vars.user}";
    #      packages = [ pkgs.home-manager ];
          stateVersion = "23.11";
        };
    #    programs.home-manager.enable = true;
      }
    ];
  };
}
