# /etc/skel/.bashrc:
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
if [[ -f ~/.dir_colors ]]; then
	eval `dircolors -b ~/.dir_colors`
else
	eval `dircolors -b /etc/DIR_COLORS`
fi

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm|aterm|kterm|gnome)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
		;;
	screen)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
		;;
esac

# Connect to existing / create new ssh-agent
ssh_lock=`netstat -xl | grep -o "/tmp/ssh-[A-Za-z0-9]*/agent.[0-9]*"`
if [[ $ssh_lock == "" ]]; then
    eval `ssh-agent`
else
    export SSH_AUTH_SOCK=$ssh_lock
fi

# Add bash-complete support
[[ -f /etc/profile.d/bash-completion.sh ]] && source /etc/profile.d/bash-completion.sh

# share

# My configs
shopt -s histappend
shopt -s extglob

export CPATH=~/local/include:$CPATH
export LIBRARY_PATH=~/local/lib:~/local/lib64:/opt/nvidia/cuda-5.0/lib64:/usr/lib64:/lib64:$LIBRARY_PATH
export LD_LIBRARY_PATH=$LIBRARY_PATH
export PERL5LIB=~/local/lib/perl:$PERL5LIB
export PYTHONPATH=~/local/lib/python:$PYTHONPATH
export MANPATH=~/local/share/man:$MANPATH
eval `~/bin/depend ~/.default_depend`
export PATH=~/bin:/opt/bin:~/local/bin:/opt/nvidia/cuda-5.0/bin:$PATH
export PKG_CONFIG_PATH=~/local:$PKG_CONFIG_PATH

export http_proxy=http://sonproxy.sandia.gov:80
export https_proxy=$http_proxy

HISTSIZE=5000

export OMP_NUM_THREADS=1
export OMPI_MPICC=clang
export OMPI_MPICXX=clang++

export HISTTIMEFORMAT='%F %T '

# standard programs
alias cp='cp -i'
alias ctest='ctest -j12'
alias diff='colordiff'
alias egrep='egrep --color'
# alias gcc='ccache'
# alias g++='ccache'
# alias gdb='gdb -tui'
alias gdb='gdb --ex run'
alias gitk='gitk --all --since="1 month ago"'
alias grep='grep --color --exclude=tags'
alias feh='feh -Fd'
alias firefox='firefox -new-tab'
alias iotop='iotop -o'
alias less='less -R'
alias libreoffice='libreoffice4.1'
alias ls='ls --color=always -v --ignore="C:*\\debuglog.txt"'
alias make='make -j12'
alias mplayer='mplayer -really-quiet'
alias mv='mv -i'
alias ninja='ninja -j12'
alias tig='tig --since="1 month ago"'
# alias ssh='ssh -Y'
# alias xterm='xterm +sb -si -sk -sl 16384'
alias vi='vim -p'

# reassign commands
alias gv="okular"
alias top='htop'
alias xterm='urxvt'

# custom commands
alias clwhite="sed -i 's/\s*$//g'"
alias excuse='echo `telnet bofh.jeffballard.us 666 2>/dev/null` | grep --color=always -o "Your excuse is:.*$"'
alias l.='ls -d .* --color=always -v'
alias localc='libreoffice'
alias loimpress='libreoffice'
alias lowriter='libreoffice'
alias lsd='ls -d --color=always -v */'
alias lsf="find -maxdepth 1 -type f | sed 's/^.\///' | grep -v '^\.' | xargs ls --color=always"
alias lt='ls -ltr'
alias org='emacs ~/.personal/org/my.org'
alias ulocate='locate -d ~/.locate.db'

# set VI mode for bash
set -o vi
bind '"\e."':yank-last-arg

# Quiet down
alias okular="be_quiet okular"
# alias stardict="be_quiet stardict"

# NET
# export BROWSER=/usr/bin/opera

source $HOME/local/share/cdargs/cdargs-bash.sh
source $HOME/local/share/git/git-completion.sh
source $HOME/local/share/bash-completion/bash_completion
# source $HOME/.xinitrc

export TRILINOS_HOME=/home/aprokop/code/trilinos/

# using vim as a pager
# export MANPAGER=/usr/bin/vimmanpager
export EDITOR=/usr/bin/vim

lsnew() { ls -lt ${1+"$@"} | head -10; }
function s() {
local arg=${1:-1};
local pt=""
while [ $arg -gt 0 ]; do
    pt="../$pt"
    arg=$(($arg - 1));
done
cd $pt >&/dev/null;
}

function dux() {
local arg=${1:-.}
du -sk $arg/* | sort -n | awk 'BEGIN{ pref[1]="K"; pref[2]="M"; pref[3]="G";} \
{
    total = total + $1;
    x = $1;
    y = 1;
    while( x > 1024 ) { x = (x + 1023)/1024; y++; }
    printf("%g%s\t",int(x*10)/10,pref[y],$2);
    for (f = 2; f <= NF; f++) {	printf("%s ", $f); }
    printf("\n");
}
END { y = 1; while( total > 1024 ) { total = (total + 1023)/1024; y++; } printf("Total: %g%s\n",int(total*10)/10,pref[y]); }'
}

xrdb -load ~/.Xresources
xmodmap ~/.Xmodmap

export GPG_TTY='tty'

export http_proxy=http://sonproxy.sandia.gov:80

# Git me harder!
export GIT_PS1_SHOWSTASHSTATE=1
#export GIT_PS1_SHOWUPSTREAM="verbose"
source /home/aprokop/local/share/git/git-prompt.sh
export PS1="\[\033[01;32m\]\h\[\033[01;34m\] \W\[\033[00;37m\]\$(__git_ps1) \[\033[01;34m\]$\[\033[00m\] "
