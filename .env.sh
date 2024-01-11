export RUSTPYTHONPATH=~/projects/rustpython/Lib

path+=(~/.nimble/bin)
path=(~/.cargo/bin $path)

export EDITOR=vim

export GOPATH=~/.go
path+=("$GOPATH"/bin)

path+=(~/.local/bin)
path+=(~/.yarn/bin)
path+=(~/.local/share/gem/ruby/3.0.0/bin)

export OPENSSL_NO_VENDOR=1

path+=(~/misc-projects/pafun)

path+=(~/clockwork/SpacetimeDB/target/debug)

# LESS="$LESS --mouse"
export SYSTEMD_LESS="FRSK --mouse"
