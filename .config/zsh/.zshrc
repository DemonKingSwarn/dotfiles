# history

HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTFILE="${XDG_CACHE_HOME:-${HOME}/.cache}/zsh/history"
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# plugin manager

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# plugins

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light jeffreytse/zsh-vi-mode

autoload -U compinit && compinit

# keybindings

bindkey -v
bindkey '^f' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# completion styling

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview "eza $realpath"
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview "eza $realpath"

# sourcing

source "${XDG_CONFIG_HOME:-${HOME}/.config}/shell/aliasrc"
source "${XDG_CONFIG_HOME:-${HOME}/.config}/shell/profile"
source "${XDG_CONFIG_HOME:-${HOME}/.config}/shell/functions"

# shell integration

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"
eval "$(atuin init zsh)"

if [ "$TERM_PROGRAM" = "tmux" ]; then
  figlet "tmux"
else 
  greet
fi
