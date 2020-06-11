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

export JAVA_HOME=/usr/lib/jvm/default
path+=("$JAVA_HOME"/bin)

path+=(/opt/depot_tools)
