#!/usr/bin/env sh

# create log
exec > >(tee -a "$HOME/install.log") 2>&1

ARCH="$(uname -m)"
GITHUB="https://github.com/demonkingswarn"
WALLPAPER_DIR="$HOME/.config/wall"
CPG_BIN="https://github.com/DemonKingSwarn/dotfiles/releases/download/0.0.1/cpg"
MVG_BIN="https://github.com/DemonKingSwarn/dotfiles/releases/download/0.0.1/mvg"
AUR_HELPER="paru"

PKGS="opendoas fastfetch dash git zoxide starship stow zsh fzf river wideriver pipewire pipewire-pulse pipewire-alsa pipewire-jack wireplumber hyprlock swww nsxiv-demon waybar swaync wezterm ghostty brave-bin floorp thunar grim slurp swappy brightnessctl playerctl rofi-wayland rofi-file-browser-extended-patched power-profiles-daemon pavucontrol blueman galculator gammastep pamixer pulsemixer ly polkit-gnome network-manager-applet udiskie xwayland-satellite copyq xdg-desktop-portal xdg-desktop-portal-hyprland wine dxvk-bin vkd3d-proton-bin proton-ge-custom rm-improved-bin aria2 wget duf gdu cyme steam heroic-games-launcher-bin gamescope hyprpicker"

mkdir -p "$HOME/.local/bin" && mkdir -p "$HOME/.cache/zsh" && mkdir -p "$HOME/.proton"
test "$HOME/.cache/zsh/history" || touch "$HOME/.cache/zsh/history"

$AUR_HELPER -S $PKGS --noconfirm

git clone --depth 1 "$GITHUB/dotfiles" $HOME/.dots
git clone --depth 1 "$GITHUB/scripts" $HOME/.scripts
git clone --depth 1 "$GITHUB/fonts" $HOME/.local/share/
git clone --depth 1 "$GITHUB/wallpapers" $WALLPAPER_DIR

fc-cache -vf

git clone --depth 1 "$GITHUB/nvim" $HOME/.config/nvim

cd "$HOME/.dots"
stow --ignore="screenshot.png" --ignore="README.org" --ignore=".git" --ignore=".assets" .

sudo cp $HOME/.config/env /etc/zsh/zshenv

chsh -s $(which zsh)

sudo ln -sf $(which dash) /bin/sh

if [ "$ARCH" = "x86_64" ]; then
  cd "$HOME"
  wget "$CPG_BIN"
  wget "$MVG_BIN"
  chmod +x cpg mvg

  sudo mv cpg /usr/local/bin
  sudo mv mvg /usr/local/bin
fi
