#!/usr/bin/env bash

set -o posix

export HISTFILE="${XDG_STATE_HOME}"/bash/history

ALIAS="$XDG_CONFIG_HOME/shell/aliasrc"
FUNCTIONS="$XDG_CONFIG_HOME/shell/functions"

source "$ALIAS"

eval "$(starship init bash)"
eval "$(zoxide init --cmd cd bash)"
eval "$(atuin init bash)"

[ -f "$HOME/.config/env" ] && source "$HOME/.config/env"
export PATH="$PATH:$HOME/.local/bin"

function help() {
    "$@" --help 2>&1 | bat --plain --language=help
}

function chst {
    [ -z $1 ] && echo "no args provided!" || (curl -s cheat.sh/$1 | bat --style=plain)
}

function gdown () {
        agent="Mozilla/5.0 (X11; Linux x86_64; rv:129.0) Gecko/20100101 Firefox/129.0"
        uuid=$(curl -sL "$1" -A "$agent" | sed -nE 's|.*(uuid=[^"]*)".*|\1|p')
        aria2c -x16 -s16 "$1&confirm=t&$uuid" -U "$agent" --summary-interval=0 -d "${2:-.}"
}
# gdown "<drive_link>"  "<to_specified_directory>"

function fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
                FZF-EOF"
}
