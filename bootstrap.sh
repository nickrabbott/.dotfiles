#! /usr/bin/env bash

set -e


# Linux and mac bootstrap
OS=$(uname -s)

packages=("stow" "tmux" "nvim")
directories=("bash" "nvim" "tmux")

if [ "$OS" = "Darwin" ]; then
    echo "MacOS detected"

	user=$(whoami)
	if [ "$user" = "root" ]; then
		read -p "For MacOS, you probably shouldn't be running as root or sudo. Are you sure (y/n)? " root_accept
		if [ "$root_accept" != "y" ]; then
			exit 1
		fi
	fi

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
    echo "Linux detected"

    if ! sudo apt --version &>/dev/null; then
        echo "This only works for systems with apt"
        exit 1
    fi

    for package in "${packages[@]}"; do
        echo "Installing $package..."
        if DEBIAN_FRONTEND=noninteractive sudo apt install -y "$package"; then
            echo "✅ OK"
        else
            echo "❌ Failed to install $package"
            exit 1
        fi
    done
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

