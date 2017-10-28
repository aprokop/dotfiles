# /etc/skel/.bashrc:
#
# This file is sourced by all *interactive* bash shells on startup, including
# some apparently interactive shells such as scp and rcp that can't tolerate any
# output. So make sure this doesn't display anything or bad things will happen!

platform="unknown"
unamestr=`uname`
if   [[ "$unamestr" == "Linux" ]]; then
    platform="linux"
elif [[ "$unamestr" == "Darwin" ]]; then
    platform="darwin"
fi

# Machine dependent parameters
host=`hostname`
MAKEPROC=1
if   [[ "$host" == "jet"* ]] ||
     [[ "$host" == "mbpro617"* ]]; then
    MAKEPROC=3
elif [[ "$host" == "geminga"* ]] ||
     [[ "$host" == "3a15778f103e" ]] ||
     [[ "$host" == "scramjet" ]]; then
    MAKEPROC=12
elif [[ "$host" == "erectus" ]]; then
    MAKEPROC=14
fi

# Set environment before non-interactive shell check, so that it is the same for
# both login and interactive shells
export PATH="~/bin:/opt/bin:~/local/bin:$PATH"
[[ "$platform" == "darwin" ]] && export PATH="/opt/local/bin:/usr/local/opt/findutils/libexec/gnubin:$PATH"
if [[ "$CPATH" != "" ]]; then
    export CPATH="~/local/include:$CPATH"
else
    export CPATH="~/local/include"
fi
# LIBRARY_PATH is used by gcc before compilation to search for directories
# containing libraries that need to be linked to your program
# export LIBRARY_PATH=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH="~/local/lib:~/local/lib64:${LD_LIBRARY_PATH}"
export MANPATH="~/local/share/man:${MANPATH}"
[[ "$platform" == "darwin" ]] && MANPATH="/usr/local/opt/findutils/libexec/gnuman:$MANPATH"
export PKG_CONFIG_PATH="~/local:$PKG_CONFIG_PATH"
export PYTHONPATH="~/local/lib64/python2.7/site-packages:${PYTHONPATH}"

# Set Modules environment
if [[ "$platform" == "linux" ]]; then
    # Initialize Modules environment for non-interactive shell
    # (copied from /etc/profile.d/modules.sh)
    if [[ $- != *i* ]] ; then
        shell=`/bin/basename \`/bin/ps -p $$ -ocomm=\``
        if [ -f /usr/share/Modules/init/$shell ]; then  . /usr/share/Modules/init/$shell;
        else                                            . /usr/share/Modules/init/sh;       fi
    fi

    if [[ -d $HOME/.modules ]]; then
        module use-append ~/.modules
        if [[ "$host" == "geminga"* ]]; then
            module load common_base
        fi

    fi
elif [[ "$platform" == "darwin" ]]; then
    source /usr/local/opt/modules/init/bash
fi

for file in \
    "$HOME/local/share/cdargs/cdargs-bash.sh" \
    "$HOME/local/share/git/git-completion.sh" \
    "/usr/share/doc/git-core-doc/contrib/completion/git-completion.bash" \
    "/etc/profile.d/bash-completion.sh" \
    "$HOME/local/share/bash-completion/bash_completion" \
    "/usr/local/etc/bash_completion" \
    "$HOME/local/share/bash-completion/completions/tmux" \
    "/etc/profile.d/autojump.sh" \
    "$HOME/.autojump/etc/profile.d/autojump.sh" \
    ; do
    [[ -s $file ]] && source $file
done

# Spack (commented out due to slow speed)
if [[ -s $HOME/local/opt/spack ]]; then
    export SPACK_ROOT=$HOME/local/opt/spack
    # Fast
    export PATH="$SPACK_ROOT/bin:$PATH"
    # Slow
    # source $SPACK_ROOT/share/spack/setup-env.sh
fi

# Test for an interactive shell. There is no need to set anything past this
# point for scp and rcp, and it's important to refrain from outputting anything
# in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive. Be done now!
	return
fi

# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
if [[ "$platform" == "linux" ]]; then
    if [[ -f ~/.dir_colors ]]; then
        eval `dircolors -b ~/.dir_colors`
    else
        eval `dircolors -b /etc/DIR_COLORS`
    fi
fi

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm|aterm|kterm|gnome)
		PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} echo -ne \"\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007\""
		;;
	screen)
		PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} echo -ne \"\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\""
		;;
esac

# Connect to existing / create new ssh-agent
ifs=$IFS
IFS='
' ssh_locks=(`netstat -xl | grep -o "/tmp/ssh-[A-Za-z0-9]*/agent.[0-9]*"`)
IFS=$ifs
ssh_lock=""
for lock in "${ssh_locks[@]}"; do
    if [[ -r $lock ]]; then
        ssh_lock=$lock
        break
    fi
done
if [[ "x$ssh_lock" == "x" ]]; then
    eval `ssh-agent`
else
    export SSH_AUTH_SOCK=$ssh_lock
fi

# My configs
shopt -s histappend
shopt -s extglob

HISTSIZE=5000

export OMP_NUM_THREADS=1

export OMPI_CFLAGS="-fdiagnostics-color"
export OMPI_CXXFLAGS="-fdiagnostics-color"

export HISTTIMEFORMAT='%F %T '

# helpers
if [[ "$platform" == "linux" ]]; then
    ls_flags="-N --color=auto -v"
elif [[ "$platform" == "darwin" ]]; then
    ls_flags="-G"
fi

# helper commands
alias chkcmd="command -v &>/dev/null"

# standard commands
chkcmd anki         && alias anki="anki -b /home/prok/.anki"
alias cal="cal -m"
chkcmd cgdb         && alias cgdb="cgdb --ex run"
alias cp="cp -ip"
chkcmd ctest        && alias ctest="ctest -j$MAKEPROC"
chkcmd colordiff    && alias diff="colordiff"
chkcmd egrep        && alias egrep="egrep --color"
chkcmd gdb          && alias gdb="gdb --ex run"
chkcmd gitk         && alias gitk="gitk --all --since='1 month ago'"
alias grep="LANG='C' grep --color --exclude=tags"
chkcmd feh          && alias feh="feh -Fd"
chkcmd firefox      && alias firefox="firefox -new-tab"
chkcmd iotop        && alias iotop="iotop -o"
chkcmd jdownloader  && alias jdownloader="be_quiet jdownloader"
chkcmd latexmk.pl   && alias latexmk="latexmk.pl -pvc"
alias less="less -R"
alias ls="ls $ls_flags"
chkcmd make         && alias make="make -j$MAKEPROC"
chkcmd matlab       && alias matlab='LD_PRELOAD="/usr/lib64/libstdc++.so.6" matlab'
chkcmd mpirun       && alias mpirun="mpirun -bind-to socket -map-by socket"
chkcmd mplayer      && alias mplayer="mplayer -really-quiet"
alias mv="mv -i"
chkcmd ninja-build  && alias ninja="ninja-build -j$MAKEPROC"
chkcmd okular       && alias okular="be_quiet okular"
chkcmd parallel     && alias parallel="parallel --no-notice"
chkcmd qstat        && alias qstat="qstat -u `whoami`"
chkcmd tig          && alias tig='tig --all --since="1 month ago"'
chkcmd pigz         && alias tgz="tar --use-compress-program=pigz"
chkcmd pbzip2       && alias tbz2="tar --use-compress-program=pbzip2"
chkcmd tmux         && alias tmux="tmux -2"
chkcmd pxz          && alias txz="tar --use-compress-program=pxz"
alias vi="vim"

# reassigned commands
chkcmd okular       && alias gv="okular"
chkcmd simple-scan  && alias skanlite="simple-scan"
chkcmd htop         && alias top="htop"
chkcmd konsole      && alias xterm="konsole"
chkcmd ninja-build && alias make="ninjac -j$MAKEPROC"
alias vim="vim -p"
chkcmd vimx         && alias vim="vimx -p"
chkcmd ipython3     && alias wcalc="ipython3"

# custom commands
ccopy(){ for i in $*; do cp -aip $i $HOME/tmp/ccopy.`basename $i`; done }
cmove(){ for i in $*; do mv -i   $i $HOME/tmp/ccopy.`basename $i`; done }
if [[ "$platform" == "linux" ]]; then
    alias clist="ls -d --color=never $HOME/tmp/ccopy.* 2>/dev/null | sed 's/.*ccopy.//'"
    alias cpaste="ls -d --color=never $HOME/tmp/ccopy.* | sed 's/.*ccopy.//' | xargs -I % mv $HOME/tmp/ccopy.% ./%"
    alias clwhite="sed -i 's/\s*$//g'"
elif [[ "$platform" == "darwin" ]]; then
    alias clist="ls -d $HOME/tmp/ccopy.* 2>/dev/null | sed 's/.*ccopy.//'"
    alias cpaste="ls -d $HOME/tmp/ccopy.* | sed 's/.*ccopy.//' | xargs -I % mv $HOME/tmp/ccopy.% ./%"
    alias clwhite="sed -i \"\" 's/[[:space:]]*$//g'"
fi
chkcmd git          && alias gauno="git status -uno"
alias history1="history | awk '{a[\$4]++ } END{for(i in a){print a[i] \" \" i}}' | sort -rn | head -n 20"
alias history2="history | awk '{a[\$2]++ } END{for(i in a){print a[i] \" \" i}}' | sort -rn | head -n 20"
alias l.="ls $ls_flags -d .*"
alias lsd="ls -d $ls_flags */"
alias lsf="find . -maxdepth 1 \( ! -regex '.*/\..*' \) -type f -print0 | sed 's/\.\///g' | xargs -0 ls $ls_flags"
alias lt="ls $ls_flags -ltrh"
chkcmd module       && alias ma="module avail"
chkcmd module       && alias ml="module load"
chkcmd module       && alias mlist="module list"
chkcmd module       && alias mu="module unload"
[[ "$platform" != "darwin" ]] && alias open="be_quiet xdg-open"
chkcmd emacs        && alias org="emacs ~/.personal/org/my.org"
[[ -d $HOME/local/opt/pdftk ]] && alias pdftk="LD_PRELOAD=$HOME/local/opt/pdftk/libgcj.so.10 $HOME/local/opt/pdftk/pdftk"
# alias ulocate="locate -d ~/.locate-home.db -d ~/.locate-data.db"
chkcmd tail         && alias tailf="tail -f"
chkcmd locate       && alias ulocate="locate -d ~/.locate.db"
chkcmd vimdiff      && alias vimdiffw="vimdiff -c 'set diffopt+=iwhite'"
chkcmd amplxe-gui   && alias vtune="amplxe-gui"
chkcmd curl         && alias wtc="curl -s http://whatthecommit.com/index.txt"

# mistypes
alias lsls="ls"
alias mak="make"
alias amke="make"
alias makemake="make"
alias mamake="make"
alias mk="make"
# CUDA
if [[ "$host" == "scramjet" ]]; then
    export CUDA_VISIBLE_DEVICES="0"
fi

# functions
function dux() {
    if [ $# -gt 0 ]; then
        du -sh  "$@" | sort -h
        du -shc "$@" | tail -n 1 | awk 'END{ print "Total: " $1}'
    else
        du -sh *  | sort -h
        du -shc * | tail -n 1 | awk 'END{ print "Total: " $1}'
    fi
}
lsnew() {
    ls -lt ${1+"$@"} | head -10;
}
rpath() {
    objdump -x $1 | grep RPATH | awk '{print $2}'
}
s() {
    local arg=${1:-1};
    local pt=""
    while [ $arg -gt 0 ]; do
        pt="../$pt"
        arg=$(($arg - 1));
    done
    cd $pt >&/dev/null;
}

# set VI mode for bash
set -o vi
bind '"\e."':yank-last-arg

# report terminated bg jobs immediately, not at the next prompt
set -b

# source $HOME/.xinitrc

export TRILINOS_HOME=$HOME/code/trilinos/

# using vim as a pager
# export MANPAGER=/usr/bin/vimmanpager
export EDITOR=/usr/bin/vim

if [[ "platform" == "linux" ]]; then
    xrdb -load ~/.Xresources
fi

export GPG_TTY='tty'

# Network
# export BROWSER=$HOME/local/opt/firefox/firefox

# Proxies
if [[ "$host" == "geminga"* ]]; then
    export http_proxy="https://sonproxy.sandia.gov:80"
    export https_proxy="https://sonproxy.sandia.gov:80"
    export ftp_proxy="https://sonproxy.sandia.gov:80"
    export rsync_proxy="https://sonproxy.sandia.gov:80"
    export no_proxy="localhost"
fi
# some programs look for all caps proxies
# export HTTP_PROXY=$http_proxy
# export HTTPS_PROXY=$https_proxy
# export FTP_PROXY=$ftp_proxy
# export RSYNC_PROXY=$rsync_proxy
# export NO_PROXY=$no_proxy

__slurm_ps1 ()
{
    salloc=`env | grep SLURM_NNODES`
    if [ "x$salloc" != "x" ]; then
        printf " slurm[%d]" `echo $salloc | cut -f 2 -d =`
    fi
}

if [[ -s $HOME/local/share/git/git-prompt.sh ]]; then
    # Git me harder!
    export GIT_PS1_SHOWSTASHSTATE=1
    #export GIT_PS1_SHOWUPSTREAM="verbose"
    source $HOME/local/share/git/git-prompt.sh

    export PS1="\[\033[01;32m\]\h\[\033[01;34m\] \W\[\033[00;37m\]\$(__git_ps1)\$(__slurm_ps1) \[\033[01;34m\]$\[\033[00m\] "
else
    export PS1="\[\033[01;32m\]\h\[\033[01;34m\] \W\[\033[00;37m\]\$(__slurm_ps1) \[\033[01;34m\]$\[\033[00m\] "
fi
