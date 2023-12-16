#
#  Git
#

{
  programs = {
    git = {
      enable = true;

    aliases = {
      a = "add";
      b = "branch";
      c = "commit";
      ca = "commit --amend";
      cm = "commit -m";
      co = "checkout";
      d = "diff";
      ds = "diff --staged";
      p = "push";
      pf = "push --force-with-lease";
      pl = "pull";
      l = "log";
      r = "rebase";
      s = "status --short";
      ss = "status";
      graph = "log --all --decorate --graph --oneline";
    };

      userEmail = "62447852+janher98@users.noreply.github.com";
      userName = "Jan Heringslake"
    };
  };
}
