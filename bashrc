
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# RVM
[ -s ${HOME}/.rvm/scripts/rvm ] && source ${HOME}/.rvm/scripts/rvm

PS1="\h:\w $ "

export PS1

# for mac os only
alias updatedb='sudo /usr/libexec/locate.updatedb'
alias ls='ls -F'
