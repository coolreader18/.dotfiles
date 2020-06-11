# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/coolreader18/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=

eval "$(~/.cargo/bin/starship init zsh)"

ASDF_DIR=/opt/asdf-vm/

plugins=( 
  git                  
  node                 
  yarn                 
  github               
  # command-not-found 
  rust                 
  cargo                
  man                  
  sudo                 
  ubuntu               
  golang                   
  cp                   
  # nim                  
  asdf
)                      

source $ZSH/oh-my-zsh.sh

compinit

source ~/.aliases.sh

source ~/.env.sh

source /usr/share/z/z.sh


# Wasienv
export WASIENV_DIR="/home/coolreader18/.wasienv"
[ -s "$WASIENV_DIR/wasienv.sh" ] && source "$WASIENV_DIR/wasienv.sh"

export WASMTIME_HOME="$HOME/.wasmtime"

export PATH="$WASMTIME_HOME/bin:$PATH"
