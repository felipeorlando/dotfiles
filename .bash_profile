# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

if [ ! -d "$HOME/bin" ]; then
  mkdir ~/bin
fi

if [[ -s $HOME/.rvm/scripts/rvm ]]; then
  source $HOME/.rvm/scripts/rvm;
fi

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
for file in ~/.{path,bash_prompt,exports,aliases,functions}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;
