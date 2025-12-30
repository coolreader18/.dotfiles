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

alias ip='ip -c=auto'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

xo() {
  xdg-open "$@" 2>/dev/null
}
xod() {
  xdg-open "$@"
  exit
}

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

command -v hub >/dev/null && eval "$(hub alias -s)"

alias url_hostname="grep '\w+\:\/\/\K[^\/]+' -oP"

url_escape() {
  python -c 'import sys, urllib.parse; print(urllib.parse.quote(sys.argv[1]))' "$1"
}

google_links() {
  curl -s "https://www.google.com/search?q=$(url_escape "$*")&client=ubuntu&sourceid=chrome&ie=UTF-8" -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_3) AppleWebKit/537.75.14 (KHTML, like Gecko) Version/7.0.3 Safari/7046A194A' |
    pup '.r > a attr{href}'
}

alias restartnm="sudo service network-manager restart"

# fix-net() {
#   while ! ([[ $1 ]] && $1 || ping -c1 example.com 2>&1); do
#     echo "Nope, restarting..."
#     restartnm
#     echo "Waiting, maybe it'll work..."
#     sleep 8s
#   done
#   echo "Done!"
# }

misc() {
  mv -v "$@" -t ~/misc
}

play-music() {
  xplayer-audio-preview ~/Music/"$1"
}

[[ $SHELL == $(which zsh) ]] && compdef '_files -W ~/Music/' play-music

alias code.='code .'

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

serve_rustdoc() {
  local args
  args=("$@")
  if [[ $# -eq 0 ]]; then
    args=("$(cargo locate-project | jq -r .root | xargs dirname)/target/doc" -p 4040 --index index.html)
  fi
  miniserve "${args[@]}"
}

cpycopy() {
  for f in "$@"; do
    mkdir -p "$(dirname "$f")"
    cp -r /home/coolreader18/cpython/Lib/"$f" -T /home/coolreader18/projects/rustpython/Lib/"$f"
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

gh_get_field() {
  gh "$1" view --json "$2" -q ".$2" | cat
}

# git aliases
alias gsw-="git switch -"
alias grbim='git rebase -i $(git_main_branch)'
alias gbm='git branch -m'
alias gbm.='git branch -m $(git_current_branch)'
alias gsync='gluc && gp'

upgrade-all() {
  paru
  cargo install-update -a
  # upgrade_oh_my_zsh
}

md2ps() {
  cat -- "$@" | pandoc -f markdown -t pdf | pdf2ps - -
}

fix_time() {
  setopt localoptions err_return pipefail
  sudo timedatectl set-ntp false
  local timespec
  timespec=${1:-$(curl -Ss "http://worldtimeapi.org/api/ip" | jq -r '.datetime')}
  timespec=$(date --date="$timespec" '+%F %T')
  echo "$timespec"
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

farquaad() {
  shitpost -f ~/Pictures/farquaad.png -b "$1" -o - | pngcopy
}

pngpaste() {
  xclip -selection clipboard -target image/png -out
}
pngcopy() {
  xclip -selection clipboard -target image/png -in
}

reinsmod() {
  sudo modprobe -r "$1" && sudo modprobe "$1"
}

fix_net() {
  reinsmod rtw88_8822ce
  sudo systemctl restart wpa_supplicant wpa_supplicant@wlp4s0.service
}

fix_mouse() {
  reinsmod i2c_hid_acpi
}

fix_bluetooth() {
  sudo systemctl restart bluetooth
}

alias shfmt='shfmt -ci -i 2'

chmkdir() {
  mkdir "$1" && cd "$1"
}
chmkdirp() {
  mkdir -p "$1" && cd "$1"
}

alias clipwc='clippaste | wc'

alias copydiff='gd | clipcopy'
alias pastediff='clippaste | patch --strip=1'

dl_textbook() {
  local libgen_id=$1
  ipfs_io_url=$(curl -sSLf http://library.lol/main/"$libgen_id" | pup 'a[href^=https://ipfs.io] attr{href}')
  local ipfs_path fname
  node -e '
const u = new URL(process.argv[1]);
console.log(u.pathname);
console.log(u.searchParams.get("filename"));
' "$ipfs_io_url" | { read -r ipfs_path; read -r fname; }
  ipfs files cp "$ipfs_path" /textbooks/"$fname"
  ipfs pin add "$ipfs_path"
  ln -sf "$ipfs_path" ~/Books/textbooks/"$fname"
}

notify_washer() {
  source ~/.laundryinfo
  local num=$(url_escape "$1")
  local email=$(url_escape "${2:-"${phonenum}@vtext.com"}")
  curl -s "https://www.laundryalert.com/cgi-bin/${pw}/LMStatus" --data-raw "Halls=${hall}&R1=V3&AppNum=${num}&T1=${email}&CallingPage=LMNotify&Type=1&Submit=Submit" | pandoc -f html -t plain
}

mkgist() {
  setopt localoptions rmstartsilent
  local gist_url=$(gist "$@" *)
  git init -b master # hopefully will change to main soon?
  git remote add origin "$(sed 's|https://gist.github.com/|git@github.com:|' <<<"$gist_url")"
  rm -f -- *
  git pull --set-upstream origin "$(git_current_branch)"
}

get_mc_skin() {
  local userurl=$(
    curl -Ssf "https://api.mojang.com/users/profiles/minecraft/$(url_escape "$1")" \
      | jq -r '@uri "https://sessionserver.mojang.com/session/minecraft/profile/\(.id)"'
    )
  local textureurl=$(
    curl -Ssf "$userurl" \
      | jq -r '.properties[] | select(.name == "textures") | .value | @base64d | fromjson | .textures.SKIN.url'
    )
  curl -f "$textureurl"
}

sshcsl() {
  SSHPASS=$(bw get password login.wisc.edu) sshpass -e ssh csl
}

vpn() {
  case $1 in
    list-active)
      systemctl show 'openvpn-client@*' | rg '^Id=' -r '' \
        | if [[ $2 = '--service-names' ]]; then
            cat
          else
            rg 'openvpn-client@(.*).service' -r '$1' | cat
        fi
      ;;
    stop-active)
      sudo systemctl stop $(vpn list-active --service-names)
      ;;
    stop|start|status|restart|kill)
      local _vpn=${2:-$_vpnname}
      if [[ -z $_vpn ]]; then
        if [[ $1 = status ]]; then
          vpn list-active
          return $?
        fi
        >&2 echo Need vpn argument
        return 1
      fi
      sudo systemctl $1 openvpn-client@$_vpn.service
      ;;
    *)
      >&2 echo "Invalid argument"
      return 1
      ;;
  esac
}

alias whatsmyip='curl https://httpbin.org/ip'

clip_shitpost() {
  pngpaste | shitpost -f - -o - "$@" | pngcopy
}

hash -d atlauncher=~/.local/share/atlauncher/instances

pyman() {
  python -c 'import sys; help(*sys.argv[1:])' "$@"
}

zmv() (
  set -e
  hlp=${@[(r)-h|--help]}
  if [[ -n $hlp ]] || [[ $# -ne 2 ]]; then
    cat >&2 <<EOF
z-aware move
mv a directory and update its new path in your z index.

usage: zmv src dest
    dest can be either the new path of the directory, or the path of
    its new parent, as with normal mv
EOF
    [[ -n $hlp ]] && exit
    exit 1
  fi
  if [[ ! -d $1 ]]; then echo >&2 "zmv: argument 1 must be a directory"; exit 1; fi
  [[ $_Z_NO_RESOLVE_SYMLINKS ]] && symarg=(-s) || symarg=()
  src=$(realpath $symarg[@] $1)
  dst=$(realpath $symarg[@] $2)
  [[ -d $dst ]] && dst=$dst/$(basename $src)
  mv $src $dst
  sed -Ei "s|^$src|$dst|" ~/.z
)

add_mailmap() {
  if [[ -f .mailmap ]]; then
    tail -1 ~/mailmap >>.mailmap
  else
    cp ~/mailmap .mailmap
  fi
}

switch_cargo_pkgs_to_pacman() (
  set -e
  for x in $(cargo install-update -l | awk '/^Package/{x=1;next}{if(x&&$1)print $1}'); do
    if pacman -Si $x >/dev/null 2>&1; then
      paru -S "$x"
      cargo uninstall $x
    else
      echo "Not $x"
    fi
  done
)

sdrg() {
  sd "$1" "$2" $(rg -l "$1")
}

updsrcinfo() {
  makepkg --printsrcinfo >.SRCINFO
}

alias patch_tokio_console='patch -p1 -i ~/clockwork/tokio-console.patch -d ~/clockwork/SpacetimeDB --no-backup-if-mismatch'

view_dupdeps() {
  if (($@[(Ie)--help])); then
    cargo depgraph "$@"
  else
    crategraph "$@" | gvpr -f ~/dupdeps.gvpr | xdot -
  fi
}

crategraph() {
  if (($@[(Ie)--help])); then
    cargo depgraph "$@"
  else
    cargo depgraph "$@" | gvpr 'BEG_G { setDflt($G, "N", "fontname", "Fira Sans"); $O=$G }' | maybe_xdot
  fi
}

xdot() {
  setopt localoptions nomonitor
  if [[ $? -eq 0 ]]; then
    command xdot - &!
  else
    command xdot "$@"
  fi
}

maybe_xdot() {
  if [[ -t 1 ]]; then
    xdot &!
  else
    cat
  fi
}

copydot() {
  dot -Tpng | pngcopy
}

alias rsync='rsync --progress'

alias adb_escape='adb shell input keyevent 82'

alias regen_pacmirrors='sudo systemctl start --wait reflector'

f2c() {
  qalc "$1 fahrenheit to celsius"
}

c2f() {
  qalc "$1 celsius to fahrenheit"
}

print_crossword() {
  local puzzle_id
  puzzle_id=$(curl -fsSL "https://www.nytimes.com/svc/crosswords/v2/oracle/daily.json" | jq '.results.current.puzzle_id')
  xo "https://www.nytimes.com/svc/crosswords/v2/puzzle/$puzzle_id.pdf?block_opacity=30"
}

cps() {
  local sec=${1:-25}
  local persec=${2:-100}
  xdotool click --repeat "$(($sec * $persec))" --delay $((1000 / $persec)) 1
}

infertz() {
  sudo timedatectl set-timezone "$(curl -sSf https://ipapi.co/timezone)"
}
settz() {
  local tz="$1"
  case "$tz" in
    east) tz=America/Detroit ;;
    central) tz=America/Chicago ;;
  esac
  sudo timedatectl set-timezone "$tz"
}

reflect() {
  sudo systemctl start reflector
}

fix_lightdm() {
  sudo systemctl restart lightdm; exit
}
