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

ASDF_DIR=/opt/asdf-vm/

plugins=(
  git
  node
  yarn
  github
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
)

source $ZSH/oh-my-zsh.sh

fpath=($fpath ~/.zfuncs)
autoload ~/.zfuncs/*

compinit

source ~/.aliases.sh

source ~/.env.sh

[[ -f /usr/share/z/z.sh ]] && source /usr/share/z/z.sh
