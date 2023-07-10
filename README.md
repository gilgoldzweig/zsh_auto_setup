# [WIP - work in progress]
Currently stil a bit broken and only supports mac.
Windows and different Linux distros, coming soon!

# Installation Script

The installation script is a bash script that automates the installation and configuration of various dependencies and tools required for a development environment setup. It is designed to work in a macOS environment with Homebrew and Git installed.

## Features

- Installs the following Homebrew packages:
- thefuck: A command-line tool that corrects your previous console command.
- fzf: A general-purpose fuzzy finder for the command line.
- micro: A modern and intuitive terminal-based text editor.
- git-jump: A tool that allows quick navigation between Git repositories.

- Installs Oh My Zsh framework and sets it as the default shell.

- Clones the zsh-autosuggestions plugin from the zsh-users/zsh-autosuggestions GitHub repository. This plugin provides suggestions as you type in the terminal, based on your command history.

- Updates the .zshrc file with configuration settings for the Powerlevel10k theme, plugin settings, aliases, and environment variables.

## Prerequisites

Before running the script, make sure you have the following prerequisites installed on your system:

- macOS
- Homebrew
- Git

## Usage

To run the installation script, follow these steps:

1. Open a terminal.
2. Download the script by cloning this repository or downloading the script file directly.
3. Navigate to the directory containing the script.
4. Run the script using the following command: