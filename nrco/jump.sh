#!/usr/bin/env bash

jump() {
  ENV="${1^^}" # UPPERCASE
  shift
  SERVER="${1,,}" # lowercase
  if [[ "$SERVER" == "appmanager" ]]; then
    SERVER="controller"
  fi
  shift
  CMD="$1"
  shift

  user=$(jq -r ".$ENV.$SERVER.user" ~/dotfiles/nrco/jump.json)
  host=$(jq -r ".$ENV.$SERVER.host" ~/dotfiles/nrco/jump.json)

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
  echo >&2 ">>>ssh "$SSH"<<<"
  if [[ $CMD != "" ]]; then
    echo >&2 ">>>:$CMD<<<"
  fi
  PASSWORD=~/passwords/.nrco_jump_dev
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
