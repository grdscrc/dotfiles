# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

export EDITOR=vim

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

if [[ ! "$PROMPT_COMMAND" =~ "history" ]]; then
    export PROMPT_COMMAND="history -a;"
fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
mkdir -p ~/.bash_histories
export HISTFILE="$HOME/.bash_histories/$(date '+%Y-%m')"
export HISTSIZE=1000
export HISTFILESIZE=2000
export HISTTIMEFORMAT="%d/%m/%y %T "

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
    *)
        ;;
esac

export PAGER=less

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

/usr/bin/keychain --nogui ~/.ssh/id_ed25519
source $HOME/.keychain/NR00S17DSI19XRX-sh

PATH=$PATH":/mnt/c/Program Files/Microsoft VS Code/bin"

# SET PS1
GREEN="38;5;46;3m"
BLUE="38;5;33;1m"
RED="38;5;204m"
# export PS1="\[\e[$GREEN\]\u\[\e[0m\]@" # user
#PS1=$PS1"\[\e[$BLUE\]\h "
PS1="\[\e[$GREEN\]\w \[\e[0m\]" # working directory
PS1=$PS1"\[\e[$BLUE\]\$(git_in_prompt)\[\e[0m\]"
PS1=$PS1"\[\e[$RED\]\$(background_jobs)\[\e[0m\]\n"
export PS1

# Enable keybindings for fzf
# source /usr/share/doc/fzf/examples/key-bindings.bash
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='/usr/bin/fdfind --ignore-vcs 2> /dev/null || find .'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

source /usr/share/bash-completion/completions/git

eval "$(fasd --init auto)"

export PATH="/home/unix/git-fuzzy/bin:$PATH"
[ "${PATH#*/usr/local/go/bin:}" == "$PATH" ] && export PATH="/usr/local/go/bin:$PATH"
export PATH="/home/unix/.cargo/bin:$PATH"

# echo inputrc start
# set editing-mode vi
# GRAY='\033[1;30m'
# NC='\033[0m' # No Color
# set show-mode-in-prompt off
# set vi-ins-mode-string "\1${GRAY}_ins_${NC}\2"
# set vi-cmd-mode-string "\1${GRAY}:cmd:${NC}\2"
# echo inputrc end
# bind 'set show-mode-in-prompt on'
# bind '"jk":vi-movement-mode'

source ~/.secrets

source "$HOME/.cargo/env"

source /home/unix/.config/broot/launcher/bash/br

source ~/dotfiles/nrco/funcs.bash

# WARNING: seems you still have not added 'pyenv' to the load path.

# Load pyenv automatically by appending
# the following to
# ~/.bash_profile if it exists, otherwise ~/.profile (for login shells)
# and ~/.bashrc (for interactive shells) :

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Restart your shell for the changes to take effect.

# Load pyenv-virtualenv automatically by adding
# the following to ~/.bashrc:

eval "$(pyenv virtualenv-init -)"

export NNN_OPTS="e"
# https://github.com/jarun/nnn/wiki/Basic-use-cases#detached-text
export PATH="/home/unix/dotfiles/scripts:$PATH"
# export VISUAL=ewrap
export VISUAL=vim

# Shell-GPT integration BASH v0.2
_sgpt_bash() {
    if [[ -n "$READLINE_LINE" ]]; then
        INIT_LINE="$READLINE_LINE"
        echo -n 'GPT converting to shell...'
        RESULT=$(sgpt --shell <<< "$INIT_LINE" --no-interaction)
        echo -ne "\r\033[2K" # delete message
        READLINE_LINE="$RESULT # $INIT_LINE"
        READLINE_POINT=${#READLINE_LINE}
    fi
}
bind -x '"\C-l": _sgpt_bash'
# Shell-GPT integration BASH v0.2

source ~/repos/fzf-git.sh/fzf-git.sh

source ~/repos/fzf-simple-completion/fzf-simple-completion.sh

sgpt_bugged_chats() {
    for CHAT in $(sgpt --list-chats); do
        echo -n $CHAT...
        local ROLE1=$(jq -r '.[0].role' $CHAT)
        local CARRIAGE_RETURN=\\r
        if [[ $ROLE1 == "system" ]]; then
            echo -e "$CARRIAGE_RETURN $CHAT: ok"
        else
            echo -e "$CARRIAGE_RETURN $CHAT: >>> KO <<<"
        fi
    done
}
sgpt_diff_chats() {
    [[ $1 == "" ]] && echo >2 no chat supplied && return 1
    vimdiff $(sgpt --list-chats | grep -C 1 $1)
}

sgpt_copy_first_el() {
    [[ $1 == "" ]] && echo >2 no chat 1 supplied && return 1
    [[ $2 == "" ]] && echo >2 no chat 2 supplied && return 1
    local FIRST_ELEMENT=$(jq '.[0]' /tmp/chat_cache/$1)
    jq --argjson fe "$FIRST_ELEMENT" '. = [$fe] + .' /tmp/chat_cache/$2 > temp.json && mv temp.json /tmp/chat_cache/$2
}

sgpt_autofix() {
    local BUGGED=0
    for chat in $(sgpt --list-chats); do
        local ROLE1=$(jq -r '.[0].role' $chat)
        [[ $ROLE1 != "system" ]] && BUGGED=1
    done
    [[ $BUGGED == "0" ]] && return
    sgpt_bugged_chats
    echo >&2 "Autofixing sgpt chats..."
    local CHATS=$(sgpt_bugged_chats|cut -d':' -f1)
    local OKs=$(sgpt_bugged_chats|grep -v KO|cut -d':' -f1)
    local OK=$(sgpt_bugged_chats|grep -v KO|cut -d':' -f1|head -1)
    echo OKs "$OKs"
    echo OK "$OK"
    [[ $OK == "" ]] && echo >&2 "ALL CHATS BUGGED"
    local KO=$(sgpt_bugged_chats|grep KO|cut -d':' -f1)
    for CHAT in "$KO"; do
        sgpt_copy_first_el "$OK" "$CHAT"
    done
    sgpt_bugged_chats
}

scaffold_docker() {
    echo "version: '3.8'" > docker-compose.yml
    echo 'services:' >> docker-compose.yml
    echo '  my_service:' >> docker-compose.yml
    echo '    image: my_image' >> docker-compose.yml
    echo '    command: ["command_to_run"]' >> docker-compose.yml

    echo "FROM ubuntu:latest" > Dockerfile
    echo "# Add your commands here" >> Dockerfile
    echo 'CMD ["/bin/bash"]' >> Dockerfile
 }
. "/home/unix/.deno/env"