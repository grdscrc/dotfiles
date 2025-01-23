#!/usr/bin/env bash

methode() {
  JSON=~/dotfiles/nrco/methode.json
  local ACT="${1,,}" # lowercase
  shift
  local ENV="${1^^}" # UPPERCASE
  shift
  local APP="${1,,}" # lowercase

  local SERVER=$(jq -r ".$APP.$SERVER" $JSON)
  local SERVICE=$(jq -r ".$APP.$SERVICE" $JSON | tr '-' '_')

  case $ACT in
    restart|start_stop|stop_start)
      jump $ENV $SERVER "~/cluster/start_stop_$SERVICE.bash stop ; ~/cluster/start_stop_$SERVICE.bash start"
      ;;
    check)
      jump $ENV $SERVER "~/cluster/check_$SERVICE.bash ; test \$? -eq 110 && echo $SERVICE running || echo $SERVICE NOT running"
      ;;
    *)
      echo >&2 "act not found"
      ;;
  esac
}

