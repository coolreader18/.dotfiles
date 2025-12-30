# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=

eval "$(starship init zsh)"

export ASDF_DIR=/opt/asdf-vm/
export ASDF_DATA_DIR=~/.asdf
path=($ASDF_DATA_DIR/shims $path)

plugins=(
  git
  node
  yarn
  github
  gh
  # command-not-found
  rust
  man
  sudo
  ubuntu
  golang
  cp
  # nim
  asdf
  archlinux
  ipfs
  # gcloud
  vscode
  gradle
)

source $ZSH/oh-my-zsh.sh

fpath=($fpath ~/.zfuncs)
autoload ~/.zfuncs/*

autoload -Uz compinit
# rm ~/.zcompdump to reload
compinit

source ~/.aliases.sh

source ~/.env.sh

[[ -f /usr/share/z/z.sh ]] && source /usr/share/z/z.sh

# The following lines were added by compinstall
zstyle :compinstall filename '/home/coolreader18/.zshrc'
