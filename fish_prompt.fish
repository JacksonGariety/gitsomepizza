function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty ^/dev/null)
end

function _git_branch_name
  echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function fish_prompt
  set -l cyan (set_color -o cyan)
  set -l yellow (set_color -o yellow)
  set -l red (set_color -o red)
  set -l blue (set_color -o blue)
  set -l normal (set_color normal)

  set -l arrow " $red🍕 "
  set -l cwd $yellow(basename (prompt_pwd))

  if [ (_git_branch_name) ]
    set -l git_branch (_git_branch_name)
    set git_info " ($git_branch)"

    if [ (_is_git_dirty) ]
      set git_info "$red$git_info"
    else
      set git_info "$normal$git_info"
    end
  end

  echo -n -s $cwd $git_info $arrow $normal ' '
end

# function git_prompt_info
#   ref=$(git symbolic-ref HEAD 2> /dev/null) || return
#   echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(parse_git_dirty)(${ref#refs/heads/})$ZSH_THEME_GIT_PROMPT_SUFFIX"
# end

# PROMPT='%{$fg[yellow]%}%1~$(git_prompt_info)%{$fg[blue]%}%{$reset_color%} 🍕  '

# ZSH_THEME_GIT_PROMPT_PREFIX=" "
# ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}"
# ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}"
