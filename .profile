#!/bin/bash

export PATH="/bin"
PATH="/sbin:$PATH"
PATH="/usr/bin:$PATH"
PATH="/usr/sbin:$PATH"
PATH="/usr/local/bin:$PATH"
PATH="/usr/local/sbin:$PATH"
PATH="/Applications/MAMP/bin:$PATH"
PATH="/opt/X11/bin:$PATH"
PATH="/usr/texbin:$PATH"

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi # Rbenv shims
export CC=/usr/bin/clang #Fixes bug in 'rbenv install'

export PROFILE=$HOME/.profile 
export EDITOR=/usr/bin/vim # Default editor
# export ARCHFLAGS=-Wno-error=unused-command-line-argument-hard-error-in-future

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

# Custom prompt
# (<wdir>)
# <user>:
wdircolor="38;5;111m" #cyan
usercolor="1;32m" #green
export PS1=\
"(\[\033[$wdircolor\]\w\[\033[0m\]\])
\[\033[$usercolor\]\u\[\033[0m\]:"

. `brew --prefix`/etc/profile.d/z.sh

# if [ -f $(brew --prefix)/etc/bash_completion ]; then
#   . $(brew --prefix)/etc/bash_completion
# fi

source $HOME/.profile-aliases
source $HOME/.profile-methods
source $HOME/.profile-binds

# Use git completion with git alias 'g'
complete -o bashdefault -o default -o nospace -F _git g 2>/dev/null \
	    || complete -o default -o nospace -F _git g

eval "$(/Users/igor/work/syadem/mvx/script/bin/mvx init -)"
eval "$(/Users/igor/work/syadem/mvx/script/bin/mvx init -)"

