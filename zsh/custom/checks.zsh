if [[ $(uname) == 'Linux' ]]; then
  DOTFILES_OS=linux
elif [[ $(uname) == 'Darwin' ]]; then
  DOTFILES_OS=osx
fi