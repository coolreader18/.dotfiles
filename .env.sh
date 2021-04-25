export RUSTPYTHONPATH=~/projects/rustpython/Lib

path+=(~/.nimble/bin)
path=(~/.cargo/bin $path)

export EDITOR=vim

export GOPATH=~/.go
path+=("$GOPATH"/bin)

path+=(~/.local/bin)
path+=(~/.yarn/bin)
path+=(~/.gem/ruby/2.7.0/bin)

export OPENSSL_NO_VENDOR=1

path+=(/opt/depot_tools)
