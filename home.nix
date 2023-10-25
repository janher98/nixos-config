{ config, pkgs, ... }:

{
  home.username = "jan";
  home.homeDirectory = "/home/jan";

  home.stateVersion = "22.05";
  programs.home-manager.enable = true;
 
  home.packages = with pkgs; [ thunderbird ];
  programs.vscode = {
  enable = true;
  extensions = with pkgs.vscode-extensions; [
    james-yu.latex-workshop
  ];
};
}
