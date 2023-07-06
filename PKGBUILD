# Maintainer: demonkingswarn <demonkingswarn at protonmail dot com>
pkgname='demonkingswarn-dotfiles-git'
_pkgname='dotfiles'
pkgver=r335.8d0011d
pkgrel=1
pkgdesc='My dotfiles package. Superior to an install script.'
arch=('any')
url='https://github.com/demonkingswarn/dotfiles'
license=('Unlicense')

depends=(
'acpi'
'bat'
'base-devel'
'brightnessctl'
'bspwm'
'cmake'
'emacs-nativecomp'
'exa'
'fd'
'fzf'
'feh'
'ffmpeg'
'ghostscript'
'gnupg'
'htop'
'hyprland'
'imagemagick'
'keepassxc'
'libnotify'
'man-db'
'man-pages'
'mpv'
'mupdf'
'mako'
'neovim'
'nsxiv'
'noto-fonts'
'openssh'
'pacman-contrib'
'pulsemixer'
'swaylock'
'sxhkd'
'swayidle'
'wezterm'
'wl-clipboard'
'xclip'
'xdg-desktop-portal-hyprland'
'xdg-desktop-portal'
'xcolor'
'xorg-server'
'xorg-xinit'
'yt-dlp'
'zsh-completions'
)
makedepends=(
'git'
'stow'
)

optdepends=(
'firefox: webbrowser'
'mullvad-vpn-cli: the best vpn'
'signal-desktop: superior messenger'
'paru: aur helper'
)

source=('dotfiles::git+https://github.com/demonkingswarn/dotfiles')
md5sums=('SKIP')

pkgver() {
    cd "$srcdir/${_pkgname}"
    printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}

_progress () {
    message="$1"
    shift
    $@
    printf "\33[2K\r\033[1;32m%s\033[0m\n" "$message"
}

_manual () {
    printf "\33[2K\r\033[1;33mManual setup: %s\033[0m\n" "$@"
}

_writefiles () {
    echo "exec bspwm" > $HOME/.xinitrc
    mkdir -p $HOME/.local/share/gnupg
    chmod 700 $HOME/.local/share/gnupg
}

package() {
    _progress "[1/5] prepared zsh history and cache" mkdir -p ~/.local/state/zsh && touch ~/.local/state/zsh/history && mkdir -p ~/.cache/zsh/zcompdump-5.9
    _progress "[2/5] downloaded zsh-autosuggestions" git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions $HOME/.config/zsh/zsh-autosuggestions || true
    _progress "[3/5] symlinked config files" cd .. && stow -v --no-folding --ignore="PKGBUILD" --ignore="src" --ignore="dotfiles" --ignore="pkg" -t $HOME/.config .
    _progress "[4/5] setup wm autostart" _writefiles
    _progress "[5/5] compiled emacs packages" emacs -l ~/.config/emacs/init.el -batch
    _manual 'echo "export ZDOTDIR=$HOME/.config/zsh" | sudo tee /etc/zsh/zshenv'
    _manual 'chsh -s /bin/zsh'
    _manual 'localectl set-x11-keymap de "" "" ctrl:nocaps'
    _manual 'configure autologin: https://wiki.archlinux.org/title/Getty'
    _manual 'git clone https://aur.archlinux.org/paru.git && cd paru && makepkg -si'
}
