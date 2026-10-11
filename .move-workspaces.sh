#!/bin/bash
set -eo pipefail

_r() {
  while ! "$@"; do sleep 0.05; done
}

wmctrl_r() {
  _r wmctrl "$@"
}


wmctrl_r -Fxr Mail.org.mozilla.Thunderbird -t 4 &

closediscord() {
  local winid
  winid="$(wmctrl -lx | awk 'BEGIN {ok=0} $3 == "discord.discord" && $6 != "Updater" {print $1; ok=1} END {exit !ok}')" || return $?
  wmctrl -ic "$winid" || true
}

{
  wmctrl_r -Fr "Discord Updater" -t 3
  _r closediscord
  _r closediscord
  _r closediscord
} &

wait
