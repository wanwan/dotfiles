#!/bin/bash

git clone https://github.com/wanwan/dotfiles.private.git private
ln -s $HOME/dotfiles/emacs.d $HOME/.emacs.d

if [ -d private -a -x private/make_dotfiles_to_user_environment.sh ]; then
	private/make_dotfiles_to_user_environment.sh
fi
