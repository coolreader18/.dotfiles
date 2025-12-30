# shellcheck shell=sh

export MAKEFLAGS="-j$(nproc)"
export RUSTUP_USE_RUSTLS=1
export RUSTPYTHONPATH=~/projects/rustpython/Lib
export GOPATH=~/.go
export EDITOR=vim


_prepend_path() {
    while [ "$#" -gt 0 ]; do
        case "$PATH" in
            "$1":*|*:"$1":*|*:"$1") ;;
            *) PATH="$1:$PATH" ;;
        esac
        shift
    done
}

_append_path() {
    while [ "$#" -gt 0 ]; do
        case "$PATH" in
            "$1":*|*:"$1":*|*:"$1") ;;
            *) PATH="$PATH:$1" ;;
        esac
        shift
    done
}

_prepend_path \
    ~/.bin \
    ~/.cargo/bin \

_append_path \
    ~/.nimble/bin \
    "$GOPATH"/bin \
    ~/.local/bin \
    ~/.yarn/bin \
    ~/.local/share/gem/ruby/3.0.0/bin \
    ~/misc-projects/pafun \
    ~/clockwork/SpacetimeDB/target/debug \
    ~/.dotnet/tools \

unset _prepend_path _append_path

export OPENSSL_NO_VENDOR=1
export LIBSQLITE3_SYS_USE_PKG_CONFIG=1
# LESS="$LESS --mouse"
export SYSTEMD_LESS="FRSK --mouse"
export WASI_SDK_PATH=~/.asdf/installs/wasi-sdk/21/wasi-sdk
export COREPACK_ENABLE_AUTO_PIN=0
export QT_QPA_PLATFORMTHEME=qt5ct
export ROCKSDB_LIB_DIR=/usr/lib
