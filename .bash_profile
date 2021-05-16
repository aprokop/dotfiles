# /etc/skel/.bash_profile

# This file is sourced by bash for login shells.  The following line
# runs your .bashrc and is recommended by the bash info pages.
[[ -f ~/.bashrc ]] && . ~/.bashrc

if [[ "$(uname)" == "Darwin" ]]; then
    # Silence zsh warning on Mac OS
    export BASH_SILENCE_DEPRECATION_WARNING=1
fi
