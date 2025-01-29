#!/usr/bin/env bash

methode() {
  JSON=~/dotfiles/nrco/methode_apps.json
  FZSELECT=$(command -v fzf &> /dev/null && echo true)

  local ACT="${1,,}" # lowercase
  shift

  local ENV="${1^^}" # UPPERCASE
  if [ "$ENV" != "DEV" ] && [ "$ENV" != "QA" ] ; then
    if [[ $FZSELECT == "true" ]]; then
      echo Select methode env
      ENV=$(echo "DEV\nQA" | fzf --height=4)
      if [[ $ENV == "" ]];  then
        echo >&2 "aborted"
        return 1
      fi
    else
      echo "Available envs:\nDEV\nQA">&2
      return 1
    fi
  fi
  shift

  local APP="${1,,}" # lowercase
  if jq -e --arg KEY "$APP" 'has($KEY) | not' $JSON >/dev/null; then
    if [[ $FZSELECT == "true" ]]; then
      echo Select methode app
      APP=$(jq -r "keys[]" $JSON | fzf --no-sort --height=50%)
      if [[ $APP == "" ]];  then
        echo >&2 "aborted"
        return 1
      fi
    else
      echo "Available apps:"
      jq -r "keys[]" $JSON >&2
      return 1
    fi
  fi
  # return 1
  shift

  local SERVER=$(jq -r ".$APP.server" $JSON)
  local SERVICE=$(jq -r ".$APP.service" $JSON | tr '-' '_')

  case $ACT in
    restart|start_stop|stop_start)
      jump $ENV $SERVER "~/cluster/start_stop_$SERVICE.bash stop ; ~/cluster/start_stop_$SERVICE.bash start"
      ;;
    check)
      jump $ENV $SERVER "~/cluster/check_$SERVICE.bash ; test \$? -eq 110 && echo '$SERVICE($APP) running' || echo '$SERVICE($APP) NOT running'"
      ;;
    *)
      echo >&2 "act not found"
      ;;
  esac
}

