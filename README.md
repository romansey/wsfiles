# Workstation Files

This repository contains all files needed for setting up
and running my workstation environment. Make sure to
clone this repository including all submodules:

```sh
git clone --recurse-submodules git@github.com:romansey/wsfiles.git
```

## OS Setup

The folder `os-setup` contains scripts to prepare a freshly
installed OS to suit my needs.

## ZSH

The folder `zsh` contains my ZSH configuration. Add the
following to your `~/.zshrc` file to activate:

```sh
# wsfiles
WSFILES=(path to this repository)
WSFILES_MACHINE="MyMachine" # optional, for prompt
source "$WSFILES/zsh/init.zsh"
```

A terminal font capable of emojis and powerline characters
is required.
