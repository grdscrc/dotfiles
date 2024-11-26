#!/usr/bin/env bash

jump() {
  local ENV="${1^^}" # UPPERCASE
  shift
  local SERVER="${1,,}" # lowercase
  if [[ "$SERVER" == "appmanager" ]]; then
    SERVER="controller"
  fi
  shift
  local CMD="$1"
  shift

  local user=$(jq -r ".$ENV.$SERVER.user" ~/dotfiles/nrco/jump.json)
  local host=$(jq -r ".$ENV.$SERVER.host" ~/dotfiles/nrco/jump.json)

  if [[ "$user" == "null" ]] || [[ "$host" == "null" ]]; then
    echo >&2 "user/host not found"
    return
  fi

  if [[ $CMD == "--echo" ]]; then
    echo -n $user@$host@jump
    return
  fi

  if [[ $CMD == "--find" ]]; then
    localpath=$1
    shift
    twodirpath=`echo $localpath | sed 's|.*/\([^/]\+/[^/]\+\)/\([^/]\+\)$|\1/\2|'`
    CMD="find -path '*/$twodirpath'|xargs realpath"
  fi

  local SSH=$user@$host@jump
  local PASSWORD=~/passwords/.nrco_jump_dev
  echo >&2 ">>>sshpass -f $PASSWORD ssh "$SSH"<<<"
  if [[ $CMD != "" ]]; then
    echo >&2 ">>>:$CMD<<<"
  fi
  sshpass -f $PASSWORD ssh $SSH "$CMD"
}

jump_help() {
  t="        " # indentation for boundary
  case $1 in
    DEV)
      type jump|sed -n "/${t}DEV)/,/^${t};;/p"|grep ")"
      ;;
    QA)
      type jump|sed -n "/${t}QA)/,/^${t};;/p"|grep ")"
      ;;
    *|"")
      type jump
      ;;
  esac
}
