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

# shell integration

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"
eval "$(atuin init zsh)"

# functions

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

function lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        /usr/sbin/rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

bindkey -s '^o' 'lfcd\n'

if [ "$TERM_PROGRAM" = "tmux" ]; then
  figlet "tmux"
else 
  greet
fi
