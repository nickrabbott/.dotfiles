#! /usr/bin/env bash

set -e

user=$(whoami)
if [ "$user" = "root" ]; then
	read -p "Running as root or sudo, are you sure (y/n)? " root_accept
	if [ "$root_accept" != "y" ]; then
		exit 1
	fi
fi


# Linux and mac bootstrap
OS=$(uname -s)

packages=("stow" "tmux" "nvim")
directories=("bash" "nvim" "tmux")

if [ "$OS" = "Darwin" ]; then
    echo "MacOS detected"

    brew --version || {
		echo "Installing homebrew..."
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || {
		    echo "Failed to install Homebrew. Please install it manually from https://brew.sh"
			exit 1
		}

		brew --version || {
			echo "Problem with brew installation, sorry..."
			exit 1
		}
	}

	echo "Installing packages: $packages"
	for package in "${packages[@]}"; do
		echo "Installing $package... "
		NONINTERACTIVE=1 brew install "$package" && echo "✅ OK" || {
			echo "❌ Failed"
			exit 1
		}
	done

elif [ "$OS" = "Linux" ]; then
    # Linux
    echo "Linux bootstrap is not yet implemented"
	exit 1
else
    echo "🚫 $OS is not recognized"
	exit 1
fi


echo "Packages installed. Symlinking config files..."

for dir in "${directories[@]}"; do
	echo -n "Stowing $dir... "
	stow $dir && echo "✅" || echo "❌"
done

echo "Stowing script directory to $HOME/.dotfiles_scripts"
stow --target="$HOME" scripts

