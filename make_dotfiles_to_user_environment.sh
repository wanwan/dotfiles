#!/bin/bash

<<<<<<< HEAD
if [ ! -d $HOME/bin ]; then
	mkdir $HOME/bin
fi

git clone https://github.com/wanwan/dotfiles.private.git private
ln -s $HOME/dotfiles/emacs.d $HOME/.emacs.d
ln -s $HOME/dotfiles/bashrc $HOME/.bashrc
ln -s $HOME/dotfiles/bash_profile $HOME/.bash_profile
ln -s $HOME/dotfiles/screenrc $HOME/.screenrc
ln -s $HOME/dotfiles/xmonad $HOME/.xmonad

if [ -d private -a -x private/make_dotfiles_to_user_environment.sh ]; then
	private/make_dotfiles_to_user_environment.sh
fi
=======
ln -s $HOME/dotfiles/private/script/sync_howm.sh $HOME/bin
ln -s $HOME/dotfiles/private/script/make_daily_howm_todo.sh $HOME/bin
>>>>>>> 4ff24286d65ffcfe7a85eee48c629cd12a47b31f
