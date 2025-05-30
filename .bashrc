
export HISTFILE="${XDG_STATE_HOME}"/bash/history

shopt -s autocd

alias diff='diff --color=auto'
alias adb='HOME="$XDG_DATA_HOME"/android adb'

eval "$(starship init bash)"
eval "$(zoxide init bash)"

[ -f "$HOME/.config/env" ] && source "$HOME/.config/env"
export PATH="$PATH:$HOME/.local/bin"
