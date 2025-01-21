alias fd='fdfind'
alias docc=docker-compose
alias dctail='docker-compose logs --follow'
alias dps="docker ps --format=\"table {{.Names}}\t{{.Status}}\t{{.Image}}\""
alias dcps="docker-compose ps --format=\"table {{.Name}}\t{{.Status}}\t{{.Image}}\""
alias v="vim"
alias pscpu="ps aux --forest --sort=-%cpu"
alias psmem="ps aux --forest --sort=-%mem"
alias ranger="VISUAL=vim ranger"

source ~/dotfiles/nrco/jump.sh

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
alias batman="bat --language man"
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
    if [[ $GIT_PRMPT_CMPCT == true ]] && echo $BRANCH | grep -qe "FEATURES/M-[0-9]\+"; then
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
  local INVISIBLE_CURSOR VISIBLE_CURSOR CARRIAGE_RETURN
  INVISIBLE_CURSOR=\\033\[?25l
  VISIBLE_CURSOR=\\033\[?25h
  CARRIAGE_RETURN=\\r
  expr -- "${1:-10}" + 0 > /dev/null 2>&1 || return # check if arg is number
  END=$((SECONDS + $1))
  # echo END $END
  echo -ne $INVISIBLE_CURSOR
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
  echo -ne "$CARRIAGE_RETURN$VISIBLE_CURSOR"
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

# alias wdocker="/mnt/c/Program\ Files/Docker/Docker/Docker\ Desktop.exe ; while ! pgrep docker; do echo waiting 2s...; sleep 2; done"
wdocker() {
  /mnt/c/Program\ Files/Docker/Docker/Docker\ Desktop.exe
  i=2
  local CARRIAGE_RETURN
  CARRIAGE_RETURN=\\r
  echo
  while ! pgrep -l docker; do
    echo -ne ${CARRIAGE_RETURN}Waited for ${i}s...
    sleep 2
    ((i+=2))
  done
}
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

jump_exp() {
  jump dev appmanager "cd mnt/express && $*";
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

jog() { (cd ./agile/ && npm run $*) ; }

alias jump_tail_dev_mss_archive="jump DEV methed 'tail -f ./logfiles/methode-servlets/mss/subscriptions/Archive-subscription.log'"
alias jump_tail_qa_mss_archive="jump QA methed 'tail -f ./logfiles/methode-servlets/mss/subscriptions/Archive-subscription.log'"
alias jump_tail_dev_mss="jump DEV methed 'ls -lah ./logfiles/methode-servlets/mss/subscriptions/*.log'"
alias jump_tail_dev="jump DEV methed 'ls -lahd ./logfiles/methode-servlets/*/'"
jump_tail(){
  ENV=${1:-DEV}
  servlet=${2:-mss}
  sub=${3:-Archive}
  jump $ENV methed "tail -f ./logfiles/methode-servlets/$servlet/subscriptions/$sub-subscription.log"
}

alias op="~/windows.c/Users/igor.descayrac/AppData/Local/Microsoft/WinGet/Links/op.exe" # C:\Users\igor.descayrac\AppData\Local\Microsoft\WinGet\Links\op.exe

source ~/dotfiles/nrco/livraison.bash
