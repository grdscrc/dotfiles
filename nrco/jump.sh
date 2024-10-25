#!/usr/bin/env bash

jump() {
  AWS_HOST="awseuw1.em-nrco.int"
  DEV_JMP="nrcoadl-meth01.$AWS_HOST"

  ENV="${1^^}" # UPPERCASE
  shift
  SERVER="${1,,}" # lowercase
  shift
  CMD="$1"
  shift

  case $ENV in
    DEV)
      case $SERVER in
        cobalt)
          user=igor.descayrac
          host=methcb@$DEV_JMP
          ;;
        controller|appmanager)
          user=igor.descayrac
          host=appmanager@$DEV_JMP
          ;;
        methdig)
          user=igor.descayrac
          host=methdig@$DEV_JMP
          ;;
        methed)
          user=igor.descayrac
          host=methed@$DEV_JMP
          ;;
        elasticsearch_x_archive)
          user=cust-nrco
          host=es_arc@$DEV_JMP
          ;;
        elasticsearch_x_cobalt)
          user=cust-nrco
          host=es_cb@$DEV_JMP
          ;;
        postgresql)
          user=cust-nrco
          host=methpsql@$DEV_JMP
          ;;
        ptrack)
          user=cust-nrco
          host=methptr@$DEV_JMP
          ;;
        sso)
          user=cust-nrco
          host=methsso@$DEV_JMP
          ;;
        swing_x_cobalt)
          user=cust-nrco
          host=methcbdg@$DEV_JMP
          ;;
        swing_x_prime)
          user=cust-nrco
          host=methprdg@$DEV_JMP
          ;;
        vside)
          user=cust-nrco
          host=methvsd@$DEV_JMP
          ;;
        *)
          echo "Unknown DEV host : check `jump_help DEV`" >&2
          return 1
          ;;
      esac
      ;;
    QA)
      case $SERVER in
        cobalt:nrcoaql-methed01)
          user=cust-nrco
          host=methcb@nrcoaql-methed01.$AWS_HOST
          ;;
        cobalt:nrcocql-cobcore-baseimage)
          user=cust-nrco
          host=methcb@nrcocql-cobcore-baseimage.$AWS_HOST
          ;;
        cobalt:nrcocql-cobfe-baseimage)
          user=cust-nrco
          host=methcb@nrcocql-cobfe-baseimage.$AWS_HOST
          ;;
        controller)
          user=igor.descayrac
          host=appmanager@nrcoaql-controller01.$AWS_HOST
          ;;
        elasticsearch_x_archive)
          user=cust-nrco
          host=elastic@nrcoaql-metharc01search.$AWS_HOST
          ;;
        elasticsearch_x_cobalt:cobelastic01)
          user=cust-nrco
          host=es_cb@nrcoaql-cobelastic01.$AWS_HOST
          ;;
        elasticsearch_x_cobalt:cobelastic02)
          user=cust-nrco
          host=es_cb@nrcobql-cobelastic02.$AWS_HOST
          ;;
        elasticsearch_x_cobalt:cobelastic03)
          user=cust-nrco
          host=es_cb@nrcocql-cobelastic03.$AWS_HOST
          ;;
        elasticsearch_x_editorial)
          user=cust-nrco
          host=elastic@nrcoaql-methed01search.$AWS_HOST
          ;;
        metharc)
          user=igor.descayrac
          host=metharc@nrcoaql-metharc01.$AWS_HOST
          ;;
        methdig)
          user=igor.descayrac
          host=methdig@nrcocql-methdig01-baseimage.$AWS_HOST
          ;;
        methdig:2)
          user=igor.descayrac
          host=methdig@nrcocpl-methdig01-baseimage.$AWS_HOST
          ;;
        methed)
          user=igor.descayrac
          host=methed@nrcoaql-methed01.$AWS_HOST
          ;;
        ptrack:be)
          user=cust-nrco
          host=methptr@nrcocql-ptr01-baseimage.$AWS_HOST
          ;;
        ptrack:fe)
          user=
          host=ust-nrco@methptr@nrcoaql-methed01.$AWS_HOST
          ;;
        sso1)
          user=igor.descayrac
          host=methsso@nrcoaql-sso01.$AWS_HOST
          ;;
        sso2)
          user=cust-nrco
          host=methsso@nrcobql-sso02.$AWS_HOST
          ;;
        swing_x_cobalt)
          user=cust-nrco
          host=methcbdg@$DEV_JMP
          ;;
        swing_x_prime)
          user=cust-nrco
          host=methpridg@nrcocql-prime01-baseimage.$AWS_HOST
          ;;
        vside)
          user=cust-nrco
          host=methvsd@nrcoaql-methed01.$AWS_HOST
          ;;
        *)
          echo "Unknown QA host : check `jump_help QA`" >&2
          return 1
          ;;
      esac
      ;;
    PROD)
      case $SERVER in
        methed)
          user=igor.descayrac
          host=methed@nrcoapl-methed01.$AWS_HOST
          ;;
        *)
          echo "Unknown PROD host : check `jump_help PROD`" >&2
          return 1
          ;;
      esac
      ;;
    appmanager|"")
      user=igor.descayrac
      host=${ENV:-appmanager}@$DEV_JMP
      ;;
    *)
      echo "Unknown env : check `jump_help`" >&2
      return 1
      ;;
  esac

  export SSH=$user@$host@jump
  if [[ $CMD == "--debug" ]]; then
    echo $user@$host@jump
    echo
    # jq ".$ENV"         ~/dotfiles/jump.json
    # echo
    uuser=$(jq -r ".$ENV.$SERVER.user" ~/dotfiles/jump.json)
    hhost=$(jq -r ".$ENV.$SERVER.host" ~/dotfiles/jump.json)
    echo $uuser@$hhost@jump
    echo
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
      type jump|sed -n "/${t}DEV)/,/^${t};;/p"|grep ")"|bat --number
      ;;
    QA)
      type jump|sed -n "/${t}QA)/,/^${t};;/p"|grep ")"|bat --number
      ;;
    *|"")
      type jump|grep -v "="|bat --number --language bash
      ;;
  esac
}
