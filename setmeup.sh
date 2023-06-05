#!/usr/bin/env bash

rm -rf ~/.config/nvim
ln -s $(pwd)/nvim ~/.config/nvim

rm -rf ~/.tmux.conf
ln -s $(pwd)/tmux/tmux.conf ~/.tmux.conf
