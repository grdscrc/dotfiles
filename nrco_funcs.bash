alias fd='fdfind'
alias docc=docker-compose
alias dctail='docker-compose logs --follow'
alias dps="docker ps --format=\"table {{.Names}}\t{{.Status}}\t{{.Image}}\""
alias dcps="docker-compose ps --format=\"table {{.Name}}\t{{.Status}}\t{{.Image}}\""
alias v="vim"

epoch() {
  date +"%s"
}
nanoseconds() {
  PRECIS=$1
  date +"%${PRECIS}N"
}
alias microseconds="nanoseconds 6"
alias milliseconds="nanoseconds 3"

# unalias fzf_mini
alias fzf_mini="fzf --height=20% --info=inline"
# fzf_mini() {
#   CMD=${*:-"xargs echo"}
#   fzf --height=20% --info=inline | $CMD
# }

git_z() {
  git branch |
  grep -v "^\*" |
  fzf_mini --query=$1 --reverse |
  xargs git checkout
}
alias gz=git_z

git_feat () {
  LOCALBRANCH=`git branch|grep $1`
  REMOTEBRANCH=`git branch --remote|grep $1`
  if [[ $LOCALBRANCH != "" ]]; then
    git checkout $LOCALBRANCH
  elif [[ $REMOTEBRANCH != "" ]]; then
    git checkout $REMOTEBRANCH
  else
    read -p Description:
    DESC=`echo $REPLY | sed -e 's/ /_/g' -e 's/.*/\L&/'`
    git checkout -b FEATURES/M-$MANTIS-$DESC
  fi
}
alias feat=git_feat

alias ez="eza --all --long --git --git-repos --sort=time"
alias et="ez --tree"

warn_azerty() {
  KILL_LEFT=\\033\[1K
  KILL_RIGHT=\\033\[0K
  CARRIAGE_RETURN=\\r
  # ANSI Escape Sequences: https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797#erase-functions
  echo -n heads up handsome
  sleep 1
  echo -ne ${CARRIAGE_RETURN}check your keyboard cause it might be in azerty
  sleep 2
  echo -ne ${CARRIAGE_RETURN}byeee$KILL_RIGHT
  sleep .2
  echo -ne $KILL_LEFT$CARRIAGE_RETURN
}

alias .b=". ~/.bashrc"
alias v.b="vim ~/.bashrc"
alias v.v="vim ~/.vimrc"
alias ew="warn_azerty; ez"
alias bat=batcat
alias baj="bat --language json"
alias jpaths="jq 'paths(scalars) | join(\".\")'"
alias jfz="jq -r 'paths(scalars) as \$p | [(\$p | join(\".\")), getpath(\$p)] | join(\" : \")' |fzf"
alias pz="pbpaste | jfz"
alias curly="curl -s -o /dev/null -w '%{http_code}\n'"
alias jz=jazz
alias fugitive='vim +:Git +:only'
alias fug=fugitive
alias npz="jq -r '.scripts|keys[]' package.json | fzf_mini --preview='jq \'.scripts.\\\"{}\\\"' package.json\""
alias ub=unbuffer

# trash() { mkdir ~/.trash 2> /dev/null ; mv "$@" ~/.trash/ ; }

gordon() {
  unbuffer $@ | bat --force-colorization
}

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}
# export PS1="\u@\h \[\033[34m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "
git_short_status() {
  git status -s 2>/dev/null |awk '{print $1}'|sort -ur|tr "\n" '_'
}

git_in_prompt() {
  if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    BRANCH=$(parse_git_branch)
    if echo $BRANCH | grep -qe "FEATURES/M-[0-9]\+"; then
      BRANCH=`[[ $BRANCH =~ [0-9]+ ]] && echo ${BASH_REMATCH[0]} || echo $BRANCH`
    fi
    echo "($BRANCH)" # $(git_short_status))"
  fi
}

lines() {
  tr "${1:-:}" '\n'
}
path_lines() {
  echo $PATH|lines
}

spin_boy() {
  NO_CU=\\033\[?25l
  YE_CU=\\033\[?25h
  CARRIAGE_RETURN=\\r
  expr -- "${1:-10}" + 0 > /dev/null 2>&1 || return # check if arg is number
  END=$((SECONDS + $1))
  # echo END $END
  echo -ne $NO_CU
  while [ $SECONDS -lt $END ]; do
    echo -ne "$CARRIAGE_RETURN/"
    sleep .1
    echo -ne "$CARRIAGE_RETURN-"
    sleep .1
    echo -ne "$CARRIAGE_RETURN\\"
    sleep .1
    echo -ne "$CARRIAGE_RETURN|"
    sleep .1
    echo -ne "$CARRIAGE_RETURN-"
    sleep .1
  done
  echo -ne "$CARRIAGE_RETURN$YE_CU"
}

curl_text() {
  url=$1
  selector=${2:-body}
  curl -s "$1" | \
    htmlq "$2"| \
    sed -e 's/<[^>]*>//g' #| \ awk '{$1=$1;print}'
}

rename_terminal() {
    dir=`pwd | cut -d "/" -f $(($(grep -o "/" <<< $(pwd) | wc -l) + 1))`
    name=${1:-$dir}
    echo -ne "\033]0;"$name"\007"
}
alias rt=rename_terminal

alias dctail="docc logs --follow"
c() {
  if [[ $1 == "" ]]; then
    dir=.
  else
    dir=`fasd -R $1|head -1`
  fi
  echo code $dir \&
}

alias wdocker="/mnt/c/Program\ Files/Docker/Docker/Docker\ Desktop.exe ; while ! pgrep docker; do echo waiting 2s...; sleep 2; done"
zrt() {
  z $1 && rt $1
}
alias err='echo >&2'

loop(){
  count=0
  while true; do
    eval $*
    ((count++))

    echo -n 3.0
    for i in {2..0}; do
      for j in {9..0}; do
        sleep 0.1
        err -ne "\r$i.$j"s
      done
    done
    err "Run #$count..."
  done
}
alias lp=loop

npm_scripts(){
  run=`npm run`
  scripts=`echo "$run" | egrep "^  " | sed 's/^[[:space:]][[:space:]]//' # | awk '{ORS=NR%2?" # ":"\n"; print}'`
  echo "$scripts"
}

# export SSH_AUTH_SOCK=$(/mnt/c/Windows/System32/wsl.exe -u $USER echo \$SSH_AUTH_SOCK)
alias tm=tmux
alias tmr=tmuxinator

alias unbold='sed -e "s/1;/0;/g"'
tight() {
  width=${1:-80}
  sed -E "s/^(.{$width}).*$/\1/"
}

alias codium=/mnt/c/Users/igor.descayrac/AppData/Local/Programs/VSCodium/bin/codium

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
        controller)
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

jump_exp() {
  host=${1:-appmanager}
  shift
  jump "$host" "$*";
}

alias functions="bind -P"

prompt () {
  read -n 1 -r -p "${*:-"Run next command"} [y/n] : "
  echo
  [ "${REPLY,,}" == "y" ]
}

dry_first () {
  cmd=$*
    for opt in --dry-run ""; do
      echo \> ${*/\{OPT\}/$opt}
  ${*/\{OPT\}/$opt}
  [[ "$opt" -ne "" ]] && prompt "Run real?" || break
    done
}

alias shgpt="sgpt --shell"
alias codegpt="sgpt --code"
alias replgpt="sgpt --list-chats|cut --delimiter=/ --fields=4|fzf_mini|xargs -I {} sgpt --repl {}"
alias x=xargs
alias ripgrep=rg
# alias med_mss_dry="prompt 'MED dry-run' && (cd /home/unix/dev/Eidos/agile && npm run med -- mss igor.descayrac ~/passwords/.nrco_jump_dev --dry-run)"
alias med_mss="prompt 'MED' && (cd /home/unix/dev/Eidos/agile && npm run med -- mss igor.descayrac ~/passwords/.nrco_jump_dev)"
# alias med_mss="med_mss_dry && med_mss_live"
med_service() {
  opts=$*
    if [ -n "$*" ]; then
      echo === $opts ===
        fi
        MEDJSON=/home/unix/dev/Eidos/agile/med.json
        SERVICES_COUNT=`jq -r 'keys | length' $MEDJSON`
        SERVICE=`jq -r 'keys[]' $MEDJSON | fzf --height=$((SERVICES_COUNT + 1)) --info=inline`
        if [ -z "$SERVICE" ]; then
          return 1
            fi
            echo "=== MED deploy $SERVICE ==="
            (cd /home/unix/dev/Eidos/agile && npm run med -- $SERVICE igor.descayrac ~/passwords/.nrco_jump_dev $opts)
            echo "=== MED deployed $SERVICE ==="
}

med_delta() {
  files=$*
    MEDJSON=/home/unix/dev/Eidos/agile/med.json
    SERVICES_COUNT=`jq -r 'keys | length' $MEDJSON`
    SERVICE=`jq -r 'keys[]' $MEDJSON | fzf --height=$((SERVICES_COUNT + 1)) --info=inline`
    if [ -z "$SERVICE" ]; then
      return 1
        fi
        echo "=== MED delta $SERVICE ==="
        for file in "$@"; do
          echo "Argument: $file"
            if [ -e "methed/server-config/worker/methode-servlets/scripts/mss/$file" ]; then
              jump dev methed "cat /methode/methed/methode-servlets/scripts/mss/$file" 2>/dev/null | \
                delta methed/server-config/worker/methode-servlets/scripts/mss/$file -
                fi
                if [ -e "methed/server-config/worker/methode-servlets/conf/mss/$file" ]; then
                  jump dev methed "cat /methode/methed/methode-servlets/conf/mss/$file" 2>/dev/null | \
                    delta methed/server-config/worker/methode-servlets/conf/mss/$file -
                    fi
                    done
}

eigile() {
  (cd ./agile/ && npm run $*)
}

alias jump_tail_dev_mss_archive="jump DEV methed 'tail -f ./logfiles/methode-servlets/mss/subscriptions/Archive-subscription.log'"
jump_tail(){
  ENV=dev
  servlet=mss
  sub=Archive
  jump $ENV methed "tail -f ./logfiles/methode-servlets/$servlet/subscriptions/$sub-subscription.log"
}

alias op="~/windows.c/Users/igor.descayrac/AppData/Local/Microsoft/WinGet/Links/op.exe" # C:\Users\igor.descayrac\AppData\Local\Microsoft\WinGet\Links\op.exe
