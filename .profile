#!/bin/bash

export PROFILE=$HOME/.profile 
export EDITOR=/usr/bin/vim # Default editor

export HISTSIZE=9001 # Reasonable HISTSIZE

# Don't put duplicate lines in the history. See bash(1) for more options.
# ignoredups - causes lines matching the previous history entry to not be saved
# ignorespace - lines which begin with a space character are not saved in the history list
# ignoreboth - shorthand for ignorespace and ignoredups
# erasedups - causes all previous lines matching the current line to be removed from the history list before that line is saved
export HISTCONTROL=ignoreboth:erasedups

if [[ -z $TMUX ]]; then # Outside tmux
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

  /usr/bin/ssh-add ~/.ssh/mesvaccins-igor
}

if [ -f "${SSH_ENV}" ]; then
  . "${SSH_ENV}" > /dev/null
  ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
    start_agent;
  }
else
  start_agent;
fi

. `brew --prefix`/etc/profile.d/z.sh

source $HOME/.secrets # For secret things such as api tokens
source $HOME/.profile-aliases
source $HOME/.profile-methods
source $HOME/.git-completion.sh
source $HOME/.rbenv.sh

brew_check_updates

xcode-select --install 2>/dev/null
