#!/usr/bin/env bash

methode() {
  JSON=~/dotfiles/nrco/methode_apps.json
  FZSELECT=$(command -v fzf &> /dev/null && echo true)

  local ACT="${1,,}" # lowercase
  shift

  local ENVIRONMENT="${1^^}" # UPPERCASE
  if [ "$ENVIRONMENT" != "DEV" ] && [ "$ENVIRONMENT" != "QA" ] ; then
    if [[ $FZSELECT == "true" ]]; then
      echo Select methode env
      ENVIRONMENT=$(echo -e "DEV\nQA" | fzf --height=4)
      if [[ $ENVIRONMENT == "" ]];  then
        echo >&2 "aborted"
        return 1
      fi
    else
      echo "Available envs:\nDEV\nQA">&2
      return 1
    fi
  fi
  shift

  echo ACT $ACT
  echo ENVIRONMENT $ENVIRONMENT
  if [[ $ACT == "instances" ]]; then
    if [[ $ENVIRONMENT != "QA" ]]; then
      echo >&2 "Only QA env is supported"
      return 1
    fi
    jump QA controller "~/admin/get_aws_as_instaces_qa.py"
    return 0
  elif [[ $ACT == "xopversionqa" ]]; then
    if [[ $ENVIRONMENT != "QA" ]]; then
      echo >&2 "Only QA env is supported"
      return 1
    fi
    IP1="10.18.112.210"
    IP2="10.18.113.90"
    GIT_FILES="methode-servlets/conf/swing/com.eidosmedia.swing.web-app/templates/objectpanel/cross-panel/{BRANCH,COMMITHASH,LASTCOMMITDATETIME,VERSION}"
    jump QA controller "ssh methdig@$IP1 'for f in $GIT_FILES; do echo \$f; echo -en \t ; cat \$f; echo; done'" 
    jump QA controller "ssh methdig@$IP2 'for f in $GIT_FILES; do echo \$f; echo -en \t ; cat \$f; echo; done'"
    return 0
  fi

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
      jump $ENVIRONMENT $SERVER "~/cluster/start_stop_$SERVICE.bash stop ; ~/cluster/start_stop_$SERVICE.bash start"
      ;;
    check)
      jump $ENVIRONMENT $SERVER "~/cluster/check_$SERVICE.bash ; test \$? -eq 110 && echo '$SERVICE($APP) running' || echo '$SERVICE($APP) NOT running'"
      ;;
    *)
      echo >&2 "act not found"
      ;;
  esac
}

