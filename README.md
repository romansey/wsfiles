# Workstation Files

This repository contains all files needed for setting up
and running my workstation environment. Make sure to
clone this repository including all submodules.

## OS Setup

The folder `os-setup` contains script to prepare a freshly
installed OS to my needs.

## ZSH

The folder `zsh` contains my ZSH configuration. Add the
following to your `~/.zshrc` file to activate:

```sh
WSFILES=(path to this repository)
source "$WSFILES/zsh/init.zsh"
```

A terminal font capable of emojis and powerline characters
is required.