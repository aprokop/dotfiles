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

# My configs
shopt -s histappend
shopt -s extglob

if [[ "$CPATH" != "" ]]; then export CPATH=:$CPATH; fi
export CPATH=~/local/include${CPATH}
# LD_LIBRARY_PATH is used by your program to search for directories containing
# the libraries after it has been successfully compiled and linked
# LIBRARY_PATH is used by gcc before compilation to search for directories
# containing libraries that need to be linked to your program
if [[ "x$LD_LIBRARY_PATH" != "x" ]]; then export LD_LIBRARY_PATH=:$LD_LIBRARY_PATH; fi
export LD_LIBRARY_PATH=~/local/lib:~/local/lib64:/opt/nvidia/cuda-5.0/lib64${LD_LIBRARY_PATH}
export LIBRARY_PATH=$LD_LIBRARY_PATH
export PERL5LIB=~/local/lib/perl:$PERL5LIB
export GOROOT=~/local/opt/go-1.2.1
export PYTHONPATH=~/local/lib64/python2.6/site-packages:$PYTHONPATH
export MANPATH=~/local/share/man:$MANPATH
eval `~/bin/depend ~/.default_depend`
if [[ "$PATH" != "" ]]; then export PATH=:$PATH; fi
export PATH=~/bin:/opt/bin:~/local/bin:/opt/nvidia/cuda-5.0/bin${PATH}
export PKG_CONFIG_PATH=~/local:$PKG_CONFIG_PATH

HISTSIZE=5000

# module use-append ~/.modules

export OMP_NUM_THREADS=1
export OMPI_MPICC=clang
export OMPI_CFLAGS='-fdiagnostics-color'
export OMPI_MPICXX=clang++
export OMPI_CXXFLAGS='-fdiagnostics-color'

export HISTTIMEFORMAT='%F %T '

# standard commands
alias cal='cal -m'
alias cgdb='cgdb --ex run'
alias cp='cp -ip'
alias ctest='ctest -j12'
alias diff='colordiff'
alias egrep='egrep --color'
alias gcc='gcc -fdiagnostics-color=auto'
# alias gdb='gdb -tui'
alias gdb='gdb --ex run'
alias gitk='gitk --all --since="1 month ago"'
alias grep='LANG="C" grep --color --exclude=tags'
alias feh='feh -Fd'
alias firefox='firefox -new-tab'
alias iotop='iotop -o'
alias less='less -R'
alias libreoffice='libreoffice4.3'
alias ls='ls --color=always -v --ignore="C:*\\debuglog.txt"'
# alias make='make -j12'
alias mplayer='mplayer -really-quiet'
alias mv='mv -i'
alias ninja='ninja -j12'
alias parallel='parallel --no-notice'
alias tig='tig --all --since="1 month ago"'
alias tgz='tar --use-compress-program=pigz'
alias tbz2='tar --use-compress-program=pbzip2'
alias txz='tar --use-compress-program=pxz'
# alias ssh='ssh -Y'
# alias xterm='xterm +sb -si -sk -sl 16384'
alias vi='vim -p'

# reassigned commands
alias gv="okular"
alias top='htop'
alias xterm='urxvt'

# custom commands
alias clwhite="sed -i 's/\s*$//g'"
alias gauno='git status -uno'
alias history1="history | awk '{a[\$4]++ } END{for(i in a){print a[i] \" \" i}}' | sort -rn | head -n 20"
alias history2="history | awk '{a[\$2]++ } END{for(i in a){print a[i] \" \" i}}' | sort -rn | head -n 20"
alias l.='ls -d .* --color=always -v'
alias localc='libreoffice'
alias loimpress='libreoffice'
alias lowriter='libreoffice'
alias lsd='ls -d --color=always -v */'
alias lsf="find -maxdepth 1 -type f | sed 's/^.\///' | grep -v '^\.' | xargs ls --color=always"
alias lt='ls -ltr'
alias make='ninjac -j12'
alias org='emacs ~/.personal/org/my.org'
alias ulocate='locate -d ~/.locate.db'

# set VI mode for bash
set -o vi
bind '"\e."':yank-last-arg

# Quiet down
alias okular="be_quiet okular"
# alias stardict="be_quiet stardict"

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

# Network
export BROWSER=/home/aprokop/local/opt/firefox/firefox

# Proxies
export http_proxy="http://sonproxy.sandia.gov:80"
export https_proxy=$http_proxy
export ftp_proxy=$http_proxy
export rsync_proxy=$http_proxy
export no_proxy="localhost"
# some programs look for all caps proxies
export HTTP_PROXY=$http_proxy
export HTTPS_PROXY=$http_proxy
export FTP_PROXY=$http_proxy
export RSYNC_PROXY=$http_proxy
export NO_PROXY=$no_proxy

# Git me harder!
export GIT_PS1_SHOWSTASHSTATE=1
#export GIT_PS1_SHOWUPSTREAM="verbose"
source /home/aprokop/local/share/git/git-prompt.sh
export PS1="\[\033[01;32m\]\h\[\033[01;34m\] \W\[\033[00;37m\]\$(__git_ps1) \[\033[01;34m\]$\[\033[00m\] "
