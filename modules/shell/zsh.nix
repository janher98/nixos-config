#
#  Shell
#

{ pkgs, vars, unstable, ... }:

{
  users.users.${vars.user} = {
    shell = pkgs.zsh;
  };

    environment.systemPackages = with pkgs; [
    starship
    nitch
  ]++
  (with unstable; [
    fastfetch         # Neofetch replacement
  ]); 

  programs = {
    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      histSize = 100000;

      ohMyZsh = {                               # Plug-ins
        enable = true;
        plugins = [ "git" "zsh-interactive-cd"];
      };

      shellInit = ''
        # Spaceship
        # source ${pkgs.spaceship-prompt}/share/zsh/site-functions/prompt_spaceship_setup
        autoload -U promptinit; promptinit
        
        eval "$(starship init zsh)"
        # Hook direnv
        #emulate zsh -c "$(direnv hook zsh)"
        nitch
        #eval "$(direnv hook zsh)"
      '';                                       # Theming
    };
  };
}
