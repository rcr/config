#/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

export PATH=~/bin:$PATH

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
#case "$TERM" in
#xterm-color)
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#    ;;
#*)
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#    ;;
#esac

# Comment in the above and uncomment this below for a color prompt
PS1='\[\033[01;47m\][\t]${debian_chroot:+($debian_chroot)}\u@\h\:\w\$\[\033[00m\] '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
fi

# some aliases
alias la='ls -A'
alias l='ls -CF'
alias ll='ls -lh'
alias pvxcore='cd ~/sandboxes/PvxCoreApplication/'
alias pvxcore_master='cd ~/master/PvxCoreApplication'
alias pvxcore_next='cd ~/next/PvxCoreApplication'
alias pvxlib='cd ~/zope212/lib/python2.5/site-packages'
alias runzope='cd ~/zope212/zope-server; ./bin/runzope'
alias epicurom='cd ~/sandboxes/epicurom'
alias runepicurom='~/bin/google_appengine/dev_appserver.py ~/sandboxes/epicurom/'
alias gig='git grep'
alias gia='git add'
alias gid='git diff'
alias gif='git fetch'
alias gifm='git format-patch origin/master'
alias gifn='git format-patch origin/next'
alias gib='git branch -av'
alias gil='git log'
alias gis='git status'
alias gip='git format-patch'
alias gica='git commit -a'
alias gic='git commit'
alias gick='git checkout'
alias gidc='git diff --check'
alias exp='cd ~/sandboxes/PvxCoreApplication; vi -c :Ex'
alias scastor='ssh castor2'
alias saube='ssh aube'
alias sithaque='ssh ithaque'
alias spollux='ssh pollux'
alias terminator='terminator -mf'
alias get_sql_backup="cd ~/download; scp castor2:/var/lib/postgresql/pgdump_provexi_prod.sql ."
alias del_pyc='find ~/sandboxes/PvxCoreApplication -name "*.pyc" -exec rm {}  \;'
alias del_swp='find ~/sandboxes/PvxCoreApplication -name "*.swp" -exec rm {}  \;'
alias del_foncmen='rm ~/GED/foncmen*'
alias vis='vi -S ~/.vim/session.vim'
alias apply_master='cd  ~/master/PvxCoreApplication; git am -3  ~/master/patch/*'
alias apply_next='cd  ~/next/PvxCoreApplication; git am -3  ~/next/patch/*'
alias push_master='git push origin master; clean_master'
alias push_next='git push origin next; clean_next'
alias clean_master='mv ~/master/patch/* ~/master/applied'
alias clean_next='mv ~/next/patch/* ~/next/applied'
alias ll_master='ll ~/master/patch'
alias ll_next='ll ~/next/patch'
alias push_local_config="cd ~; git push origin master"
alias tail_prod="saube 'tail -f -n 40 /var/pvx/zope212/zeo-client0/log/event.log' | ccze"
#alias tail_ith_sql="sithaque 'sudo tail -f -n 100 /usr/local/pgsql/data/pg_log/\`sudo ls -tr /usr/local/pgsql/data/pg_log/|tail -n 1\`' |ccze -A"
alias tail_ith_sql="sithaque 'sudo tail -f -n 100 /usr/local/pgsql/data/pg_log/\`sudo ls -tr /usr/local/pgsql/data/pg_log/|tail -n 1\`' |lwatch -i-"
alias tail_ith_select="sithaque 'sudo tail -f -n 200 /usr/local/pgsql/data/pg_log/\`sudo ls -tr /usr/local/pgsql/data/pg_log/|tail -n 1\`' |ccze -A |grep -i select"
alias create_http_server="python -m SimpleHTTPServer 9900"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

## enable to connect with ssh without password
#if [ -f .ssh-agent ]; then
#    .ssh-agent
#else
#    killall ssh-agent
#    ssh-agent > .ssh-agent
#    ssh-add ~/.ssh/id_rsa
#fi

export MOZ_NO_REMOTE=1
#export PYTHONSTARTUP=/home/rom/.config/pythonConfig.py
