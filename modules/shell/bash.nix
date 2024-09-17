#
#  Bash
#

{ pkgs, vars, stable, ... }:

{
  users.users.${vars.user} = {
    shell = pkgs.bashInteractive;
  };

  environment.systemPackages = with pkgs; [
    starship
  ]++
  (with stable; [
    fastfetch         # Neofetch replacement
  ]); 

  programs = {
    bash = {
      enableCompletion = true;

      shellInit = ''
        fastfetch
        eval "$(starship init bash)"
      '';                                       # Theming
    };
  };
}
