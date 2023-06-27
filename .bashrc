export HISTFILE="${XDG_STATE_HOME}"/bash/history

shopt -s autocd

alias diff='diff --color=auto'

eval "$(starship init bash)"
eval "$(zoxide init bash)"

[ -f "$HOME/.config/env" ] && source "$HOME/.config/env"
export PATH="/home/demonkingswarn/.pat/bin:$PATH"
