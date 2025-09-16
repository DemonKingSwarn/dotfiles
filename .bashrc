#!/usr/bin/env bash

export HISTFILE="${XDG_STATE_HOME}"/bash/history

shopt -s autocd

ALIAS="$XDG_CONFIG_HOME/shell/aliasrc"
FUNCTIONS="$XDG_CONFIG_HOME/shell/functions"

source "$ALIAS"
#source "$FUNCTIONS"

eval "$(starship init bash)"
eval "$(zoxide init --cmd cd bash)"

[ -f "$HOME/.config/env" ] && source "$HOME/.config/env"
export PATH="$PATH:$HOME/.local/bin"
