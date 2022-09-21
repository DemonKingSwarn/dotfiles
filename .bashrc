export HISTFILE="${XDG_STATE_HOME}"/bash/history

alias diff='diff --color=auto'

eval "$(starship init bash)"
eval "$(zoxide init bash)"

[ -f "$HOME/.config/env" ] && source "$HOME/.config/env"
