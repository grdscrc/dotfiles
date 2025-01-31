#!/usr/bin/env bash

jump() {
  JUMPJSON=~/dotfiles/nrco/jump.json

  local ENVIRONMENT="${1^^}" # UPPERCASE
  if jq -e --arg KEY "$ENVIRONMENT" 'has($KEY) | not' $JUMPJSON >/dev/null; then
    echo Select env
    select ENVIRONMENT in DEV QA; do
      case $option in
        DEV)
          echo "DEV selected"
          break
          ;;
        QA)
          echo "QA selected"
          break
          ;;
        *)
          echo "Invalid option"
          ;;
      esac
    done
    echo ENVIRONMENT $ENVIRONMENT
  fi
  shift

  local SERVER="${1,,}" # lowercase
  if jq --arg ENVIRONMENT "$ENVIRONMENT" --arg SERVER "$SERVER" -e '.[$ENVIRONMENT]|has($SERVER) | not' $JUMPJSON >/dev/null; then
    select SERVER in $(jq -r ".$ENVIRONMENT | keys[]" $JUMPJSON); do
      if [[ $SERVER == "" ]];  then
        echo >&2 "aborted"
        return 1
      fi
      echo "$SERVER selected"
    done
  fi
  if [[ "$SERVER" == "appmanager" ]]; then
    SERVER="controller"
  fi
  shift

  local CMD="$1"
  shift

  local user=$(jq -r ".$ENVIRONMENT.$SERVER.user" $JUMPJSON)
  local host=$(jq -r ".$ENVIRONMENT.$SERVER.host" $JUMPJSON)

  if [[ "$user" == "null" ]] || [[ "$host" == "null" ]]; then
    echo >&2 "user/host not found"
    return 1
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

jump_exp() {
  jump dev appmanager "cd mnt/express && $*";
}

alias jump_tail_dev_mss_archive="jump DEV methed 'tail -f ./logfiles/methode-servlets/mss/subscriptions/Archive-subscription.log'"
alias jump_tail_qa_mss_archive="jump QA methed 'tail -f ./logfiles/methode-servlets/mss/subscriptions/Archive-subscription.log'"
alias jump_tail_dev_mss="jump DEV methed 'ls -lah ./logfiles/methode-servlets/mss/subscriptions/*.log'"
alias jump_tail_dev="jump DEV methed 'ls -lahd ./logfiles/methode-servlets/*/'"
jump_tail(){
  ENVIRONMENT=${1:-DEV}
  servlet=${2:-mss}
  sub=${3:-Archive}
  jump $ENVIRONMENT methed "tail -f ./logfiles/methode-servlets/$servlet/subscriptions/$sub-subscription.log"
}

