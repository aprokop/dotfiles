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
export PATH="~/bin:/opt/bin:~/local/bin:${PATH}"
[[ "$platform" == "darwin" ]] && export PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"
export CPATH="~/local/include:${CPATH}"
# LIBRARY_PATH is used by gcc before compilation to search for directories
# containing libraries that need to be linked to your program
# export LIBRARY_PATH=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH="~/local/lib:~/local/lib64:${LD_LIBRARY_PATH}"
export MANPATH="~/local/share/man:${MANPATH}"
[[ "$platform" == "darwin" ]] && MANPATH="/usr/local/opt/findutils/libexec/gnuman:$MANPATH"
export PKG_CONFIG_PATH="~/local:$PKG_CONFIG_PATH"
export PYTHONPATH="~/local/lib64/python2.7/site-packages:${PYTHONPATH}"

if [[ "$host" == "jet"* ]]; then
    # MATLAB has trouble figuring out where Java is
    # Without this line (on jet) matlab crashes and takes X server with it
    export MATLAB_JAVA=/usr/lib/jvm/java-1.8.0/jre
fi

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
fi

for file in \
    "$HOME/local/share/bashmarks/bashmarks.sh" \
    "$HOME/local/share/git/git-completion.sh" \
    "/usr/share/doc/git-core-doc/contrib/completion/git-completion.bash" \
    "/etc/profile.d/bash-completion.sh" \
    "$HOME/local/share/bash-completion/bash_completion" \
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
    ls_flags="-N --color=auto"
elif [[ "$platform" == "darwin" ]]; then
    ls_flags="-G"
fi

# standard commands
alias anki="anki -b /home/prok/.anki"
alias cal="cal -m"
alias cgdb="cgdb --ex run"
alias cp="cp -ip"
alias ctest="ctest -j$MAKEPROC"
alias diff="colordiff"
alias egrep="egrep --color"
# alias gdb="gdb -tui"
alias gdb="gdb --ex run"
alias gitk="gitk --all --since='1 month ago'"
alias grep="LANG='C' grep --color --exclude=tags"
alias feh="feh -Fd"
alias firefox="firefox -new-tab"
alias iotop="iotop -o"
alias jdownloader="be_quiet jdownloader"
alias less="less -R"
# alias libreoffice="libreoffice5.0"
alias ls="ls $ls_flags -v"
alias make="make -j$MAKEPROC"
alias mpirun="mpirun -bind-to socket -map-by socket"
alias mplayer="mplayer -really-quiet"
alias mv="mv -i"
alias ninja="ninja-build -j$MAKEPROC"
alias okular="be_quiet okular"
alias parallel="parallel --no-notice"
alias qstat="qstat -u `whoami`"
alias tig='tig --all --since="1 month ago"'
alias tgz="tar --use-compress-program=pigz"
alias tbz2="tar --use-compress-program=pbzip2"
alias tmux="tmux -2"
alias txz="tar --use-compress-program=pxz"
alias ssh="ssh -X"
# alias xterm="xterm +sb -si -sk -sl 16384"
alias vi="vim"

# reassigned commands
alias gv="okular"
alias skanlite="simple-scan"
command -v htop > /dev/null 2>&1 && alias top="htop"
command -v konsole > /dev/null 2>&1 && alias xterm="konsole"
alias vim="vim -p"
command -v vimx > /dev/null 2>&1 && alias vim="vimx -p"

# custom commands
ccopy(){ for i in $*; do cp -aip $i $HOME/tmp/ccopy.`basename $i`; done }
cmove(){ for i in $*; do mv -i   $i $HOME/tmp/ccopy.`basename $i`; done }
if [[ "$platform" == "linux" ]]; then
    alias clist="ls -d --color=never $HOME/tmp/ccopy.* 2>/dev/null | sed 's|[^\.]*.\.||'"
    alias cpaste="ls -d --color=never $HOME/tmp/ccopy.* | sed 's|[^\.]*.\.||' | xargs -I % mv $HOME/tmp/ccopy.% ./%"
    alias clwhite="sed -i 's/\s*$//g'"
elif [[ "$platform" == "darwin" ]]; then
    alias clist="ls -d $HOME/tmp/ccopy.* 2>/dev/null | sed 's|[^\.]*.\.||'"
    alias cpaste="ls -d $HOME/tmp/ccopy.* | sed 's|[^\.]*.\.||' | xargs -I % mv $HOME/tmp/ccopy.% ./%"
    alias clwhite="sed -i \"\" 's/[[:space:]]*$//g'"
fi
alias gauno="git status -uno"
alias history1="history | awk '{a[\$4]++ } END{for(i in a){print a[i] \" \" i}}' | sort -rn | head -n 20"
alias history2="history | awk '{a[\$2]++ } END{for(i in a){print a[i] \" \" i}}' | sort -rn | head -n 20"
alias l.="ls $ls_flags -v -d .*"
alias localc="libreoffice"
alias lodraw="libreoffice"
alias loimpress="libreoffice"
alias lowriter="libreoffice"
alias lsd="ls -d $ls_flags -v */"
alias lsf="find . -maxdepth 1 \( ! -regex '.*/\..*' \) -type f -print0 | sed 's/\.\///g' | xargs -0 ls $ls_flags"
alias lt="ls $ls_flags -ltr"
command -v ninja-build > /dev/null 2>&1 && alias make="ninjac -j$MAKEPROC"
alias ma="module avail"
alias ml="module load"
alias mlist="module list"
alias mu="module unload"
alias open="be_quiet xdg-open"
alias org="emacs ~/.personal/org/my.org"
if [[ "$platform" == "darwin" ]]; then
    alias orgmac="open /Applications/Emacs.app/ --args ~/.personal/org/my.org"
fi
alias pdftk="LD_PRELOAD=$HOME/local/opt/pdftk/libgcj.so.10 $HOME/local/opt/pdftk/pdftk"
# alias ulocate="locate -d ~/.locate-home.db -d ~/.locate-data.db"
alias ulocate="locate -d ~/.locate.db"
alias vimdiffw="vimdiff -c 'set diffopt+=iwhite'"
alias vtune="amplxe-gui"
alias wtc="curl -s http://whatthecommit.com/index.txt"

# bashmarks
alias save='bashmarks_s';   complete -F _bashmarks_comp save
alias j='bashmarks_g';      complete -F _bashmarks_comp j
alias l='bashmarks_l';      complete -F _bashmarks_comp l
alias p='bashmarks_p';      complete -F _bashmarks_comp p
alias d='bashmarks_d';      complete -F _bashmarks_comp d

# mistypes
alias mak="make"
alias makemake="make"

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

# Git me harder!
export GIT_PS1_SHOWSTASHSTATE=1
#export GIT_PS1_SHOWUPSTREAM="verbose"
source $HOME/local/share/git/git-prompt.sh

export PS1="\[\033[01;32m\]\h\[\033[01;34m\] \W\[\033[00;37m\]\$(__git_ps1)\$(__slurm_ps1) \[\033[01;34m\]$\[\033[00m\] "
