#
#  Bash
#

{ pkgs, vars, ... }:

{
  users.users.${vars.user} = {
    shell = pkgs.bashInteractive;
  };

  environment.systemPackages = with pkgs; [
    neofetch
    starship
  ]; 

  programs = {
    bash = {
      enableCompletion = true;

      shellInit = ''
        neofetch
        eval "$(starship init bash)"
      '';                                       # Theming
    };
  };
}
