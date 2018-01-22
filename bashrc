
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PATH=$PATH:/opt/android-sdk/platform-tools:/opt/android-sdk/tools/bin:/opt/android-sdk/tools:/opt/android-sdk/emulator # Add RVM to PATH for scripting
#PATH=$PATH:$HOME/opt/android-sdk/platform-tools:$HOME/opt/android-sdk/tools/bin:$HOME/opt/android-sdk/tools # Add RVM to PATH for scripting

export ANDROID_SDK_ROOT=/opt/android-sdk/

# RVM
[ -s ${HOME}/.rvm/scripts/rvm ] && source ${HOME}/.rvm/scripts/rvm

PS1="\h:\w $ "

export PS1

# for mac os only
alias updatedb='sudo /usr/libexec/locate.updatedb'
alias ls='ls -F'
