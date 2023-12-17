{config, pkgs, ...}: {
  #home.sessionVariables.STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";

  programs.starship = 
    let 
      flavour = "latte";
    in 
    {
      enable = true;
      #enableZshIntegration = true;
      settings = {
        scan_timeout = 10;

        add_newline = true;
        line_break.disabled = false;
        battery.disabled = true;

        #format = "$username$hostname$nix_shell$character";
        #right_format = "$directory$git_branch$git_commit$git_state$git_status";
        format = 
          let
            git = "$git_branch$git_commit$git_state$git_status $git_metrics";
          in
          ''
            $username$hostname($cmd_duration) in $directory(${git}) $fill ($nix_shell) $time
            $jobs$character
          '';

        fill = {
          symbol = " ";
          disabled = false;
        };

        time = {
          format = "\\\[[$time]($style)\\\]";
          disabled = false;
          style = "bold rosewater";
        };

       cmd_duration = {
          format = " took [$duration](green)";
        };

        character = {
          success_symbol = "[❯](bold green)";
          error_symbol = "[❯](bold red)";
          vimcmd_symbol = "[❮](bold purple)";
          vimcmd_replace_symbol = "[❮](bold green)";
          vimcmd_replace_one_symbol = "[❮](bold green)";
          vimcmd_visual_symbol = "[❮](bold yellow)";
        };

        username = {
          format = "[$user](bold peach)";
          disabled = false;
          show_always = true;
        };
        
        hostname = {
          ssh_only = false;
          ssh_symbol = "";
          format = "@[$hostname](bold lavender)";
          disabled = false;
        };

        directory = {
          home_symbol = "home";
          style = "teal";
        };

        git_commit.tag_symbol = " tag ";
        git_branch = {
          format = "→ [$symbol$branch(:$remote_branch)]($style)";
          style = "bold mauve";
          symbol = " ";
        };
        
        git_commit.format = ''( [\($hash$tag\)]($style))'';
        git_state.format = " [\\($state( $progress_current/$progress_total)\\)](bold yellow)";
        git_status = {
          ahead = "↑";
          deleted = "✗";
          modified = "✶";
          staged = "✓";
          behind = "↓";
          conflicted = "±";
          diverged = "↕";
          renamed = "≡";
          stashed = "⌂";
          format = ''( [\[$all_status $ahead_behind\]]($style))'';
          style = "bold maroon";
        };

        git_metrics = {
          added_style = "bold yellow";
          deleted_style = "bold red";
          disabled = false;
        };

        nix_shell = {
          symbol = " ";
          heuristic = true;
          style = "bold lavender";
          format = "[($name \\(develop\\) <- )$symbol]($style) ";
        };

        aws.symbol = "  ";
        conda.symbol = " ";
        dart.symbol = " ";
        directory.read_only = " ";
        docker_context.symbol = " ";
        elixir.symbol = " ";
        elm.symbol = " ";
        gcloud.symbol = " ";
        golang.symbol = " ";
        hg_branch.symbol = " ";
        java.symbol = " ";
        julia.symbol = " ";
        memory_usage.symbol = "󰍛 ";
        nim.symbol = "󰆥 ";
        nodejs.symbol = " ";
        package.symbol = "󰏗 ";
        perl.symbol = " ";
        php.symbol = " ";
        python.symbol = " ";
        ruby.symbol = " ";
        rust.symbol = " ";
        scala.symbol = " ";
        shlvl.symbol = "";
        swift.symbol = "󰛥 ";
        terraform.symbol = "󱁢";

        palette = "catppuccin_${flavour}";
      } // builtins.fromTOML (builtins.readFile
        (pkgs.fetchFromGitHub
          {
            owner = "catppuccin";
            repo = "starship";
            rev = "5629d23"; # Replace with the latest commit hash
            sha256 = "sha256-nsRuxQFKbQkyEI4TXgvAjcroVdG+heKX5Pauq/4Ota0=";
          } + /palettes/${flavour}.toml));
    };
}
