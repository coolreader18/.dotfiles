# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias xo=xdg-open
ppwdx() {
  pwdx "$(pgrep "$1")"
}

alias du='du -h'
alias df='df -h'

add-types() {
  for mod in "$@"; do
    yarn add -D @types/"$mod"
  done
}

eval "$(hub alias -s)"

alias url_hostname="grep '\w+\:\/\/\K[^\/]+' -oP"

url_escape() {
  perl -MURI::Escape -e 'print uri_escape shift, , q{^A-Za-z0-9\-._~/:}' -- "$1"
}

google_links() {
  curl -s "https://www.google.com/search?q=$(url_escape "$*")&client=ubuntu&sourceid=chrome&ie=UTF-8" -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_3) AppleWebKit/537.75.14 (KHTML, like Gecko) Version/7.0.3 Safari/7046A194A' |
    pup '.r > a attr{href}'
}

alias restartnm="sudo service network-manager restart"

fix-net() {
  while ! ([[ $1 ]] && $1 || ping -c1 example.com 2>&1); do
    echo "Nope, restarting..."
    restartnm
    echo "Waiting, maybe it'll work..."
    sleep 8s
  done
  echo "Done!"
}

misc() {
  mv -v "$@" -t ~/Misc
}

play-music() {
  xplayer-audio-preview ~/Music/"$1"
}

[[ $SHELL == $(which zsh) ]] && compdef '_files -W ~/Music/' play-music

alias code.='code .'

alias cargo-install.="cargo install -f --path ."

alias edmicro=EDITOR=micro
alias edcat=EDITOR=cat

countdown() {
  local date1 now dif days
  date1=$(date +%s --date="$1")
  while now=$(date +%s); [[ $date1 -ge $now ]]; do
    ## Is this more than 24h away?
    dif=$((date1 - now))
    days=$((dif / 86400))
    echo -ne "\r$days day(s) and $(date -u --date "@$dif" +%H:%M:%S)"
    sleep 0.1
  done
  echo
}
stopwatch() {
  local date1 now dif days
  date1=$(date +%s)
  while now=$(date +%s); true; do
    dif=$((now - date1))
    days=$((dif / 86400))
    echo -ne "\r$days day(s) and $(date -u --date "@$dif" +%H:%M:%S)"
    sleep 0.1
  done
  echo
}

SERVE_RUSTDOC_CONFIG='
{
  "trailingSlash": true
}
'
serve_rustdoc() {
  local args
  args=("$@")
  if [[ $# -eq 0 ]]; then
    args=("$(cargo locate-project | jq -r .root | xargs dirname)/target/doc")
  fi
  serve "${args[@]}" -c <(echo "$SERVE_RUSTDOC_CONFIG")
}

cpycopy() {
  for f in "$@"; do
    mkdir -p "$(dirname "$f")"
    cp -r /home/coolreader18/cpython/Lib/"$f" /home/coolreader18/projects/rustpython/Lib/"$f"
  done
}
[[ $SHELL == $(which zsh) ]] && compdef '_files -W /home/coolreader18/cpython/Lib/' cpycopy

git_parent_branch() {
  git show-branch -a 2>/dev/null |
    grep '\*' |
    grep -v "$(git rev-parse --abbrev-ref HEAD)" |
    head -n1 |
    sed 's/.*\[\(.*\)\].*/\1/' |
    sed 's/[\^~].*//'
}

alias grorigin='git reset --hard origin/$(git_current_branch)'

idea() {
  setopt LOCAL_OPTIONS NO_NOTIFY NO_MONITOR
  intellij-idea-ultimate-edition "$@" >/dev/null 2>&1 &
  disown %
}

upgrade-all() {
  yay
  cargo install-update -a
  # upgrade_oh_my_zsh
}

alias gsta="git stash"

md2ps() {
  cat -- "$@" | pandoc -f markdown -t pdf | pdf2ps - -
}

fix_time() {
  sudo timedatectl set-ntp false
  local timespec
  if [[ $# -gt 0 ]]; then
    timespec=$1
  else
    timespec=$(curl -Ss "http://worldtimeapi.org/api/ip.txt" | grep -w datetime | cut -f2 -d' ')
  fi
  timespec=$(date --date="$timespec" '+%y-%m-%d %T')
  sudo timedatectl set-time "$timespec"
  sudo timedatectl set-ntp true
}

torrents() {
  {
    cd ~/Misc/torrents.csv/server/service
    target/release/torrents-csv-service
  }
}

alias vim='vim -p'
alias serve='serve -n'

farquaad() {
  shitpost -f ~/Pictures/farquaad.png -b "$1" -o - | pngcopy
}

pngpaste() {
  xclip -selection clipboard -target image/png -out
}
pngcopy() {
  xclip -selection clipboard -target image/png -in
}

fix_net() {
  sudo modprobe -r rtw88_8822ce && \
    sudo modprobe rtw88_8822ce && \
    sudo systemctl restart wpa_supplicant wpa_supplicant@wlp4s0.service
}

alias shfmt='shfmt -ci -i 2'
