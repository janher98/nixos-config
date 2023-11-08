{ lib, inputs, nixpkgs, home-manager, vars, ... }:

let
  system = "x86_64-linux";                                  # System Architecture
  pkgs = nixpkgs.legacyPackages.${system};
in
{
  "jan@nixos" = home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
#    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    extraSpecialArgs = { inherit inputs vars; };
    modules = [   #
  #    hyprland.homeManagerModules.default
  #    {wayland.windowManager.hyprland.enable = true;}                                          # Modules Used
    
      {
        home = {
          username = "${vars.user}";
          homeDirectory = "/home/${vars.user}";
    #      packages = [ pkgs.home-manager ];
          stateVersion = "22.05";
          packages = with pkgs; [ thunderbird ];
        };
    #    programs.home-manager.enable = true;
        programs.vscode = {
          enable = true;
          extensions = with pkgs.vscode-extensions; [
            james-yu.latex-workshop
          ];
        };
      }
    ];
  };
}