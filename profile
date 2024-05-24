#!/bin/bash

ls .profile.base >/dev/null && . .profile.base

export PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "

export PROFILE=$HOME/.profile 
export EDITOR=/usr/bin/vim # Default editor

export HISTSIZE=9001 # Reasonable HISTSIZE

# Don't put duplicate lines in the history. See bash(1) for more options.
# ignoredups - causes lines matching the previous history entry to not be saved
# ignorespace - lines which begin with a space character are not saved in the history list
# ignoreboth - shorthand for ignorespace and ignoredups
# erasedups - causes all previous lines matching the current line to be removed from the history list before that line is saved
export HISTCONTROL=ignoreboth:erasedups

if [[ ! -z $ENABLE_TMUX && -z $TMUX ]]; then # Outside tmux
  tmux start-server

  detached_sessions=$(tmux list-sessions | grep -v '(attached)')
  if [[ -z $detached_sessions ]]; then
    tmux new-session
  else
    first_detached_session=$(echo $detached_sessions | head -n1 | awk -F':' '{print $1}')
    tmux attach-session -t $first_detached_session
  fi

  exit
fi

# Pasted from bitbucket
export SSH_ENV=$HOME/.ssh/environment

# start the ssh-agent
function start_agent {
  echo "Initializing new SSH agent..."
  # spawn ssh-agent
  /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
  echo succeeded
  chmod 600 "${SSH_ENV}"
  . "${SSH_ENV}" > /dev/null
  /usr/bin/ssh-add
}

if [ -f "${SSH_ENV}" ]; then
  . "${SSH_ENV}" > /dev/null
  ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
    start_agent;
  }
else
  start_agent;
fi

which brew && ls `brew --prefix`/etc/profile.d/z.sh 2> /dev/null && . `brew --prefix`/etc/profile.d/z.sh

ls $HOME/.secrets 2> /dev/null && source $HOME/.secrets # For secret things such as api tokens
source $HOME/dotfiles/profile-aliases
source $HOME/dotfiles/profile-methods
source $HOME/dotfiles/git-completion.sh
source $HOME/dotfiles/rbenv.sh


which xcode-select && xcode-select --install 2>/dev/null

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
