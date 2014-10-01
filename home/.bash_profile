[[ -r ~/.bashrc ]] && . ~/.bashrc

# Setting PATH for Python 3.4
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"
export PATH

# added by setup_fb4a.sh
export ANDROID_SDK=/Users/rmk/android-sdk-macosx
export ANDROID_NDK=/Users/rmk/android-ndk-r9b
export ANDROID_HOME=${ANDROID_SDK}
export PATH=${PATH}:${ANDROID_SDK}/tools:${ANDROID_SDK}/platform-tools

export PATH=$PATH:~/src/devtools/arcanist/bin
