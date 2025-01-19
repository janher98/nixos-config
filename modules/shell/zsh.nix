#
#  Shell
#

{ pkgs, vars, ... }:

{
  users.users.${vars.user} = {
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    starship
    nitch
  ];

  programs = {
    direnv = {
      enable = true;
      loadInNixShell = true;
      direnvrcExtra = "";
      nix-direnv = {
        enable = true;
        package = pkgs.nix-direnv;
      };
    };
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
        if [[ $- == *i* ]]; then
          # Spaceship
          # source ${pkgs.spaceship-prompt}/share/zsh/site-functions/prompt_spaceship_setup
          autoload -U promptinit; promptinit

          eval "$(starship init zsh)"
          # Hook direnv
          #emulate zsh -c "$(direnv hook zsh)"
          nitch
          eval "$(direnv hook zsh)"
        fi
      '';                                       # Theming
    };
  };
}
