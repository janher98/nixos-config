{ config, pkgs, inputs, ...}:
{
  #import ../../modules/shell/starship.nix
  
  home.packages = with pkgs; [
    nitch
    starship
  ];
  programs = {
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      history.size = 100000;

      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "zsh-interactive-cd"];
      };
      initExtra = ''
        autoload -U promptinit; promptinit
        
        eval "$(starship init zsh)"
        # Hook direnv
        #emulate zsh -c "$(direnv hook zsh)"
        nitch
        #eval "$(direnv hook zsh)"
      '';                                       # Theming
      shellAliases = {
        ll = "ls -l";
        "cd.." = "cd ..";
      };
    };
  };
}
