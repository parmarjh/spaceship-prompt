# ------------------------------------------------------------------------------
# PROMPTS
# Compose prompts for different prompt variables.
# ------------------------------------------------------------------------------

# PROMPT
# Primary (left) prompt
spaceship::prompt() {
  # Compose prompt from the order
  local prompt="$(spaceship::compose_prompt $SPACESHIP_PROMPT_ORDER)"

  # Allow iTerm integration to work
  if [[ "${ITERM_SHELL_INTEGRATION_INSTALLED:-}" == "Yes" ]]; then
    prompt="%{$(iterm2_prompt_mark)%}${prompt}"
  fi

  # Should it add a new line before the prompt?
  if [[ $SPACESHIP_PROMPT_ADD_NEWLINE == true ]]; then
    prompt="${NEWLINE}${prompt}"
  fi

  # Print the prompt
  echo -n "$prompt"
}

# RPROMPT
# Optional (right) prompt
spaceship::rprompt() {
  # Compose prompt from the order
  local rprompt="$(spaceship::compose_prompt $SPACESHIP_RPROMPT_ORDER)"

  if [[ "$SPACESHIP_RPROMPT_ADD_NEWLINE" != true ]]; then
    # The right prompt should be on the same line as the first line of the left
    # prompt. To do so, there is just a quite ugly workaround: Before zsh draws
    # the RPROMPT, we advise it, to go one line up. At the end of RPROMPT, we
    # advise it to go one line down. See:
    # http://superuser.com/questions/357107/zsh-right-justify-in-ps1
    local rprompt_prefix='%{'$'\e[1A''%}' # one line up
    local rprompt_suffix='%{'$'\e[1B''%}' # one line down
    rprompt="$rprompt_prefix$rprompt$rprompt_suffix"
  fi

  # Print the rprompt
  echo -n "$rprompt"
}

# PS2
# Continuation interactive prompt
spaceship::ps2() {
  local char="${SPACESHIP_CHAR_SYMBOL_SECONDARY="$SPACESHIP_CHAR_SYMBOL"}"
  spaceship::section "$SPACESHIP_CHAR_COLOR_SECONDARY" "$char"
}

# Compose whole prompt from sections
# USAGE:
#   spaceship::compose_prompt [section...]
spaceship::compose_prompt() {
  # Option EXTENDED_GLOB is set locally to force filename generation on
  # argument to conditions, i.e. allow usage of explicit glob qualifier (#q).
  # See the description of filename generation in
  # http://zsh.sourceforge.net/Doc/Release/Conditional-Expressions.html
  setopt EXTENDED_GLOB LOCAL_OPTIONS

  # Reset the first prefix value
  _spaceship_prompt_opened="$SPACESHIP_PROMPT_FIRST_PREFIX_SHOW"

  # Treat the first argument as list of prompt sections
  # Compose whole prompt from diferent parts
  for section in $@; do
    spaceship::render_section "$(spaceship::get_cache $section)"
  done
}

# Render the prompt. Compose variables using prompt functoins.
# USAGE:
#   spaceship::populate
spaceship::populate() {
  PROMPT='$(spaceship::prompt)'
  RPROMPT='$(spaceship::rprompt)'
  PS2='$(spaceship::ps2)'
}
