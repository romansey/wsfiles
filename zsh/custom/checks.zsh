if [[ $(uname) == 'Linux' ]]; then
  WSFILES_OS=linux
elif [[ $(uname) == 'Darwin' ]]; then
  WSFILES_OS=osx
fi