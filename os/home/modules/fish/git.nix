{ editor }:
{
  programs.fish = {

    interactiveShellInit = ''
      set --export GIT_EDITOR ${editor}
    '';

    shellAbbrs = {
      add = "git add";
      amend = "git commit --amend";
      cherry = "git cherry-pick";
      ci = "git commit";
      ci-empty = "git ci --allow-empty -m empty";
      clone = "git clone";
      co = "git checkout";
      fetch = "git fetch";
      log = "git log";
      merge = "git merge";
      pull = "git pull";
      push = "git push";
      rebase = "git rebase";
      revert = "git revert";
      show = "git show";
      staged = "git diff --cached";
      stash = "git stash";
    };

    functions = {
      # Lists git branches in order of their last commit date, with most recent
      # branches appearing at the bottom. Shows date, committer, and branch name.
      br = {
        body = ''
          git for-each-ref \
              --sort=committerdate refs/heads/ \
              --format='%(committerdate:short)%09%(authorname)%09%(refname:short)' \
              | column -t -s "$(echo -e '\t')"
        '';
      };

      # Enhanced git status command. First just run a normal git status. Then
      # search for diffs that have added/removed the string "TODO" and display
      # the results. (Ideally this would only show additions, not removals.)
      st = {
        body = ''
          git status; and begin
              set IFS (echo -en "\n\b")
              set todo (git diff HEAD --name-only -Gtodo)
              if test -n "$todo"
                  echo '#'
                  echo '# Todo:'
                  echo '#'
                  set c (echo -e '\e[0;34m')
                  set r (echo -e '\e[0m')
                  echo "$todo" | sed "s/.*/#       $c&$r/"
              end
          end
        '';
      };
    };
  };
}
