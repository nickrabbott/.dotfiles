## Setup
Clone the repository into the home directory and use stow to symlink the configuration files

On macOS and Linux (apt based systems)
```bash
cd $HOME
git clone git@github.com:nickrabbott/.dotfiles.git
cd .dotfiles
./bootstrap.sh
```

Store anything unique to a machine for bash in ~/.bash_local. It will get loaded by .bashrc
