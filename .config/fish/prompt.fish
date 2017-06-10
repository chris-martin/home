functions --copy fish_prompt default_fish_prompt

function fish_prompt
  if [ $FISH_PROMPT ]
    echo "$FISH_PROMPT"
  else
    set -l color_cwd
    set -l suffix
    switch $USER
        case root toor
            if set -q fish_color_cwd_root
                set color_cwd $fish_color_cwd_root
            else
                set color_cwd $fish_color_cwd
            end
            set suffix '#'
        case '*'
            set color_cwd $fish_color_cwd
            set suffix (echo -e '\e[0;31m\342\235\257\e[0;33m\342\235\257\e[0;32m\342\235\257\e[0m')
    end

    echo -n -s "$USER" @ (prompt_hostname) ' ' (set_color $color_cwd) (prompt_pwd) (set_color normal) " $suffix "
  end
end
