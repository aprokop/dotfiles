fish_vi_key_bindings

# helper commands
alias chkcmd="type -q"

# standard commands
chkcmd anki            ; and alias anki="anki -b /home/prok/.anki"
chkcmd cgdb            ; and alias cgdb="cgdb --ex run"
                       ; and alias cp="cp -ip"
chkcmd ctest           ; and alias ctest="ctest -j$MAKEPROC"
chkcmd colordiff       ; and alias diff="colordiff"
chkcmd egrep           ; and alias egrep="egrep --color"
chkcmd gdb             ; and alias gdb="gdb --ex run"
chkcmd gitk            ; and alias gitk="gitk --all --since='1 month ago'"
                       ; and alias grep="LANG='C' grep --color --exclude=tags"
chkcmd feh             ; and alias feh="feh -Fd"
chkcmd firefox         ; and alias firefox="firefox -new-tab"
chkcmd iotop           ; and alias iotop="iotop -o"
chkcmd jdownloader     ; and alias jdownloader="be_quiet jdownloader"
chkcmd latexmk.pl      ; and alias latexmk="latexmk.pl -pvc"
                       ; and alias less="less -R"
                       ; and alias ls="ls $ls_flags"
chkcmd make            ; and alias make="make -j$MAKEPROC"
chkcmd matlab          ; and alias matlab='LD_PRELOAD="/usr/lib64/libstdc++.so.6" matlab'
chkcmd mpirun          ; and alias mpirun="mpirun -bind-to socket -map-by socket"
chkcmd mplayer         ; and alias mplayer="mplayer -really-quiet"
                       ; and alias mv="mv -i"
chkcmd ninja-build     ; and alias ninja="ninja-build -j$MAKEPROC"
chkcmd okular          ; and alias okular="be_quiet okular"
chkcmd parallel        ; and alias parallel="parallel --no-notice"
chkcmd qstat           ; and alias qstat="qstat -u `whoami`"
chkcmd tig             ; and alias tig='tig --all --since="1 month ago"'
chkcmd pigz            ; and alias tgz="tar --use-compress-program=pigz"
chkcmd pbzip2          ; and alias tbz2="tar --use-compress-program=pbzip2"
chkcmd tmux            ; and alias tmux="tmux -2"
chkcmd pxz             ; and alias txz="tar --use-compress-program=pxz"
                       ; and alias vi="vim"

# reassigned commands
chkcmd okular          ; and alias gv="okular"
chkcmd simple-scan     ; and alias skanlite="simple-scan"
chkcmd htop            ; and alias top="htop"
chkcmd konsole         ; and alias xterm="konsole"
chkcmd ninja-build     ; and alias make="ninjac -j$MAKEPROC"
                       ; and alias vim="vim -p"
chkcmd vimx            ; and alias vim="vimx -p"
chkcmd ipython3        ; and alias wcalc="ipython3"

# custom commands
chkcmd git             ; and alias gauno="git status -uno"
                             alias history1="history | awk '{a[\$4]++ } END{for(i in a){print a[i] \" \" i}}' | sort -rn | head -n 20"
                             alias history2="history | awk '{a[\$2]++ } END{for(i in a){print a[i] \" \" i}}' | sort -rn | head -n 20"
                             alias l.="ls $ls_flags -d .*"
                             alias lsd="ls -d $ls_flags */ 2>/dev/null"   # empty directory lists need error redirection
                             alias lsf="find . -maxdepth 1 \( ! -regex '.*/\..*' \) -type f -print0 | sed 's/\.\///g' | xargs -0 ls $ls_flags"
                             alias lt="ls $ls_flags -ltrh"
chkcmd module          ; and alias ma="module avail"
chkcmd module          ; and alias ml="module load"
chkcmd module          ; and alias mlist="module list"
chkcmd module          ; and alias mu="module unload"
chkcmd emacs           ; and alias org="emacs ~/.personal/org/my.org"
chkcmd tail            ; and alias tailf="tail -f"
chkcmd vimdiff         ; and alias vimdiffw="vimdiff -c 'set diffopt+=iwhite'"
chkcmd amplxe-gui      ; and alias vtune="amplxe-gui"
chkcmd curl            ; and alias wtc="curl -s http://whatthecommit.com/index.txt"

# mistypes
alias lsls="ls"
alias mak="make"
alias amke="make"
alias makemake="make"
alias mamake="make"
alias mk="make"
