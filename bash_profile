
# own script
PATH=$HOME/bin:$PATH

# haskell
PATH=$HOME/.cabal/bin:$PATH

# ruby gem
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"

# android
case "$OSTYPE" in
  solaris*) echo "SOLARIS" ;;
  darwin*)
	PATH=$PATH:/opt/android-sdk-macosx/platform-tools:/opt/android-sdk-macosx/tools
  	;;
  linux*)
	PATH=$PATH:/opt/android-sdk/platform-tools:/opt/android-sdk/tools/bin:/opt/android-sdk/tools:/opt/android-sdk/emulator
	export ANDROID_SDK_ROOT=/opt/android-sdk/	
	;;
  bsd*)     echo "BSD" ;;
  msys*)    echo "WINDOWS" ;;
  *)        echo "unknown: $OSTYPE" ;;
esac


PATH=$PATH:/usr/local/bin

# jakarta ant
ANT_HOME=/Users/waka/bin/apache-ant-1.9.2
PATH=$PATH:$ANT_HOME/bin

# JVM additional classpath
CLASSPATH=$CLASSPATH:${HOME}/lib/AozoraEpub3/AozoraEpub3.jar
export CLASSPATH

# libvirt
export LIBVIRT_DEFAULT_URI="qemu:///system"

export PATH
export ANT_HOME

LC_CTYPE=ja_JP.UTF-8
export LC_CTYPE


#if [ -f ~/.bashrc ]; then
#	. ~/.bashrc
#fi
