#  ____  _____ __  __  ___  _   _
# |  _ \| ____|  \/  |/ _ \| \ | | (c) Swarnaditya Singh aka DemonKingSwarn
# | | | |  _| | |\/| | | | |  \| | Github- https://github.com/demonkingswarn
# | |_| | |___| |  | | |_| | |\  |
# |____/|_____|_|  |_|\___/|_| \_|
#

# Enable colors and change prompt:
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
PS2="> "

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.local/state/zsh/history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1


# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

function chst {
    [ -z $1 ] && echo "no args provided!" || (curl -s cheat.sh/$1 | bat --style=plain)
}

fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

#yt() {
#    mpv ytdl://ytsearch:"$*"
#}

upload() {
    [ -z $1 ] && echo "no args given" || uwu=$(curl -F"file=@$1" 0x0.st | tail -n 1 | wl-copy)
}

hst() {
    hist=$(cat $HOME/.local/state/zsh/history | sort | uniq | fzf)
    printf "%s" "$hist" | wl-copy
}

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

plugins_dir="/usr/share/zsh/plugins"

source "$HOME/.config/shell/profile"
source "$HOME/.config/shell/aliasrc"
source "$plugins_dir/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$plugins_dir/fzf-tab/fzf-tab.plugin.zsh"

eval "$(zoxide init zsh)"

if [ "$TERM" = "linux" ] ; then
        colorscript -r
else
    eval "$(starship init zsh)"
fi

figlet "fsociety"
