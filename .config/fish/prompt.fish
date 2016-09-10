functions --copy fish_prompt default_fish_prompt

function fish_prompt
  if [ $FISH_PROMPT ]
    echo "$FISH_PROMPT"
  else
    default_fish_prompt
  end
end
