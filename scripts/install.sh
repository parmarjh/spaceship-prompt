#!/usr/bin/env sh
#
# Author: Denys Dovhan, denysdovhan.com
# https://github.com/spaceship-prompt/spaceship-prompt
#
# Inspired by: https://github.com/sindresorhus/pure

link() {
  mkdir -p "$1"
  ln -sf "$PWD/spaceship.zsh" "$1/prompt_pure_setup"
  ln -sf "$PWD/async.zsh" "$1/async"

  echo "Spaceship is linked to $1."
  echo
  echo "Don't forget to initialize the prompt system (if not so already) and choose Spaceship."
  echo "To do so, add those lines in your ~/.zshrc:"
  echo "    autoload -U promptinit; promptinit"
  echo "    prompt spaceship"
}

if [ -e /opt/homebrew/bin/zsh ]; then
  link /opt/homebrew/share/zsh/site-functions
  exit 0
elif [ -e /usr/local/bin/zsh ]; then
  link /usr/local/share/zsh/site-functions
  exit 0
elif [ -e /bin/zsh ] || [ -e /usr/bin/zsh ]; then
  for dest in /usr/share/zsh/site-functions /usr/local/share/zsh/site-functions; do
    if [ -d "$dest" ]; then
      link "$dest"
      exit 0
    fi
  done
fi

link "$PWD/functions"

echo "ERROR: Could not automagically symlink the prompt. You can either:"
echo
echo "1. Add the following to your \`.zshrc\`:"
echo "    fpath+=('$PWD/functions')"
echo "2. Or check out the readme on how to do it manually: "
echo "    https://github.com/sindresorhus/pure#manually"
