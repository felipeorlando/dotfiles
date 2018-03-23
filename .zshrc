export ZSH="$HOME/.oh-my-zsh";
export PATH="$HOME/bin:$PATH";

if [ ! -d "$HOME/bin" ]; then
  mkdir ~/bin
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

ZSH_THEME="robbyrussell"

plugins=(
  git
  chuck
  gem
  npm
  rvm
  rails
  rake
)

source $ZSH/oh-my-zsh.sh

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
for file in ~/.{path,exports,aliases,functions}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;
