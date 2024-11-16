#!/usr/bin/env bash

# install kitty
if ! command -v kitty 2>&1 >/dev/null
then
	curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin \
		launch=n
	echo 'export PATH=~/.local/kitty.app/bin:$PATH' >> ~/.zshrc
fi


# configure nvim
rm -rf ~/.config/nvim
ln -s $(pwd)/nvim ~/.config/nvim

if [[ ! -d ~/.local/share/nvim/site/pack/packer/start/packer.nvim ]]; then
	git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
fi

# configure i3
rm -rf ~/.config/i3
mkdir -p ~/.config/i3
ln -s $(pwd)/i3/config ~/.config/i3/config
ln -s $(pwd)/i3/background ~/.config/i3/background
rm -rf ~/.config/rofi
mkdir -p ~/.config/rofi
ln -s $(pwd)/i3/rofi/config.rasi ~/.config/rofi/config.rasi

# configure tmux
rm -rf ~/.tmux.conf
ln -s $(pwd)/tmux/tmux.conf ~/.tmux.conf

if [[ ! -d ~/.tmux/plugins/tpm ]]; then
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi


# install n for node
if [[ ! -d ~/n ]]; then
	curl -L https://bit.ly/n-install | bash
fi
