# .dotfiles
This repository is where I keep my bash, Neovim, and tmux configurations, all neatly managed with [GNU Stow](https://www.gnu.org/software/stow/). It’s set up as a personal project to make my environment consistent and quickly deployable across different machines. Though it’s tailored for my use, you might find something useful or inspiring here.

## Prerequisites
- Git
- GNU Stow (Install via your package manager or follow the [official instructions](https://www.gnu.org/software/stow/manual/stow.html#Installation))

## Setup
Clone the repository into the home directory and use stow to symlink the configuration files

```bash
cd $HOME
git clone git@github.com:nickrabbott/.dotfiles.git
cd .dotfiles
stow bash config tmux
```

Store anything unique to a machine for bash in ~/.bash_local. It will get loaded by .bashrc
