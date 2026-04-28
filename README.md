# Workstation Files

This repository contains all files needed for setting up and running my workstation environment.
Make sure to clone this repository including all submodules:

```sh
git clone --recurse-submodules git@github.com:romansey/wsfiles.git
```

## ZSH

The folder `zsh` contains my ZSH configuration.
Add the following to your `~/.zshrc` file to activate:

```sh
# wsfiles
WSFILES=(path to this repository)
WSFILES_MACHINE="MyMachine" # optional, for prompt
source "$WSFILES/zsh/init.zsh"
```

A [terminal font capable of emojis and powerline characters](https://github.com/powerline/fonts) is required.

## AI Agents

The `ai` folder contains configuration files for the usage of opencode and Claude Code in a VM-based sandbox environment.
Use the command `ai` to start and shell into the sandbox.
Inside the sandbox, various tools are available (see [VM config](./ai/sandbox/ai-sandbox.yaml)).
Run `./ai/agent-config/init.sh` to make my opencode and Claude Code configuration available to both the workstation and the sandbox.

The sandbox requires `lima` to be installed on the workstation.
