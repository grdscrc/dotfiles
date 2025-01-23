med_service() { livrer_service dev $* ; }
meq_service() { livrer_service qa $* ; }
livrer_service() {
  EENV=$1 # ENV Eidos
  shift
  APP=$1
  shift
  opts=$*
  if [ -n "$*" ]; then
    echo === ENV:${EENV^^} $opts ===
  fi
  if [ -z $APP ] || [ "$APP" == "-" ]; then
    CHEMINS=/home/unix/dev/Eidos/agile/apps_chemins.json
    APPS_COUNT=`jq -r 'keys | length' $CHEMINS`
    APP=`jq -r 'keys[]' $CHEMINS | fzf --height=$((APPS_COUNT + 1)) --info=inline`
    if [ -z "$APP" ]; then
      return 1
    fi
  fi
  echo "=== APP:$APP ==="
  if [ $EENV == "dev" ]; then
    task=med
  elif [ $EENV == "qa" ]; then
    task=meq
  else
    return 1
  fi
  (cd /home/unix/dev/Eidos/agile &&
    npm run $task -- $APP igor.descayrac ~/passwords/.nrco_jump_dev $opts)
  if [ $? -eq 0 ]; then
    echo "=== $APP a ete Mise En $EENV ==="
  else
    echo "!!! $APP n'a pas ete Mise En $EENV !!!"
  fi
}

update_xop() { 
  APP=cross-panel

  XOP_DIR=/home/unix/dev/eidos-cross-panel
  EID_DIR=/home/unix/dev/Eidos/agile

  (cd $XOP_DIR && git diff --quiet --exit-code)
  if [ $? -ne 0 ]; then
    echo >&2 "!!! cross-panel worktree dirty !!!"
    git status
    return 1
  fi

  echo "=== CROSS-PANEL:PUBLISH ==="
  (cd $XOP_DIR && npm run publish:debug)
  if [ $? -ne 0 ]; then
    echo "!!! La publication de cross-panel a echoue !!!"
    return 1
  fi

  echo "=== EIDOS:UPDATE:CROSS-PANEL ==="
  (cd $EID_DIR && npm run update:xop:debug)
  if [ $? -ne 0 ]; then
    echo "!!! La maj de cross-panel a echoue !!!"
    return 1
  fi
}

med_xop() { 
  update_xop
  [ $? -ne 0 ] && return 1
  echo continuing && sleep 5
  EID_DIR=/home/unix/dev/Eidos/agile
  echo "=== EIDOS:MED:XOP ==="
  (cd $EID_DIR && npm run med:xop -- igor.descayrac ~/passwords/.nrco_jump_dev $OPTS)
  if [ $? -ne 0 ]; then
    echo >&2 "!!! $APP n'a pas ete Mise En DEV !!!"
    return 1
  fi
  echo "=== $APP a ete Mise En DEV ==="
}

xop_version() { 
  if [[ $1 == "" ]]; then
    echo >&2 "!!! Environnement non specifie !!!"
    return 1
  fi
  (cd /home/unix/dev/Eidos/agile && \
    npm run xop:version -- "$1" cross-panel igor.descayrac ~/passwords/.nrco_jump_dev)
}
