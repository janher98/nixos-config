#
#  Bash
#

{ pkgs, vars, unstable, ... }:

{
  users.users.${vars.user} = {
    shell = pkgs.bashInteractive;
  };

  environment.systemPackages = with pkgs; [
    starship
  ]++
  (with unstable; [
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
