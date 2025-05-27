## Setup
Clone the repository into the home directory and use stow to symlink the configuration files

```bash
cd $HOME
git clone git@github.com:nickrabbott/.dotfiles.git
cd .dotfiles
```

On macOS (will handle tmux, stow, and neovim install)
```
./bootstrap.sh
```

On Linux (tmux, neovim, and gnu-stow pre-installed)
```
stow tmux nvim bash
stow --target="$HOME" scripts
```

Store anything unique to a machine for bash in ~/.bash_local. It will get loaded by .bashrc
