#!/bin/bash

git clone https://github.com/wanwan/dotfiles.private.git private
ln -s $HOME/dotfiles/emacs.d $HOME/.emacs.d
ln -s $HOME/dotfiles/bashrc $HOME/.bashrc
ln -s $HOME/dotfiles/bash_profile $HOME/.bash_profile
ln -s $HOME/dotfiles/screenrc $HOME/.screenrc
ln -s $HOME/dotfiles/xmonad $HOME/.xmonad

if [ -d private -a -x private/make_dotfiles_to_user_environment.sh ]; then
	private/make_dotfiles_to_user_environment.sh
fi
