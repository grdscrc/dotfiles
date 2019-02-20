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

. `brew --prefix`/etc/profile.d/z.sh

. $HOME/.secrets # For secret things such as api tokens
. $HOME/.profile-aliases
. $HOME/.profile-methods
. $HOME/.git-completion.sh
. $HOME/.rbenv.sh

. $HOME/.syadem-profile

eval "$(/Users/igor/work/syadem/hackerman/bin/hm init -)"
eval "$(/Users/igor/work/syadem/hackerman/bin/hm init -)"

export GOOGLE_API_KEY="no"
export GOOGLE_DEFAULT_CLIENT_ID="no"
export GOOGLE_DEFAULT_CLIENT_SECRET="no"

# ssh-add ~/.ssh/mesvaccins-igor

MYSQL_CONTAINER=mv-development-database
