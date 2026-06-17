#!/bin/bash

set +e  # ne pas stopper le script si un paquet échoue

DOTFILES="$HOME/dotfiles"

# ─── Paquets pacman ───────────────────────────────────────────
PACMAN_PACKAGES=(
    # Outils de base
    git
    vim
    gvim
    neovim
    zsh
    wl-clipboard
    tmux
    ripgrep
    fd

    # Terminaux & WM
    kitty
    alacritty
    waybar
    hyprland
    xdg-desktop-portal-hyprland
    rofi
    dunst
    hyprpaper

    # Apps
    brightnessctl
    keepassxc
    firefox
    obsidian
    docker
    syncthing
    htop
    pavucontrol
    ttf-jetbrains-mono-nerd
    ttf-noto-nerd
    ttf-font-awesome

    # LaTeX
    texlive-meta
    evince

    # Langages
    python
    python-pip
    gcc
    make
    cmake
    jdk-openjdk
    go
    ghc
    stack
    opam
    nodejs
    npm
)

# ─── Paquets AUR ─────────────────────────────────────────────
AUR_PACKAGES=(
    vesktop-bin
    lazygit
    wlogout
)

# ─────────────────────────────────────────────────────────────

echo "==> Installation des paquets pacman"
sudo pacman -S --needed --noconfirm "${PACMAN_PACKAGES[@]}"

echo "==> Installation de yay (AUR helper)"
if ! command -v yay &> /dev/null; then
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ~
else
    echo "    yay déjà installé, skip"
fi

echo "==> Installation des paquets AUR"
yay -S --needed --noconfirm "${AUR_PACKAGES[@]}"

echo "==> Installation de Rust (via rustup)"
if ! command -v rustc &> /dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
else
    echo "    rust déjà installé, skip"
fi

echo "==> Initialisation opam (OCaml)"
if command -v opam &> /dev/null; then
    opam init -y --disable-sandboxing
    eval $(opam env)
fi

echo "==> Création des dossiers vim"
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/swap
mkdir -p ~/.vim/undo

echo "==> Création des dossiers de config"
mkdir -p ~/.config/hypr
mkdir -p ~/.config/waybar
mkdir -p ~/.config/kitty
mkdir -p ~/.config/alacritty

echo "==> Création des symlinks"
ln -sf "$DOTFILES/hypr/hyprland.conf"        ~/.config/hypr/hyprland.conf
ln -sf "$DOTFILES/waybar/config"             ~/.config/waybar/config
ln -sf "$DOTFILES/waybar/style.css"          ~/.config/waybar/style.css
ln -sf "$DOTFILES/kitty/kitty.conf"          ~/.config/kitty/kitty.conf
ln -sf "$DOTFILES/alacritty/alacritty.toml"  ~/.config/alacritty/alacritty.toml
ln -sf "$DOTFILES/.bashrc"                   ~/.bashrc
ln -sf "$DOTFILES/.vimrc"                    ~/.vimrc

echo ""
echo "==> Terminé ! Relance ton shell ou fais 'source ~/.bashrc'"
echo "==> Pense à relancer ton shell pour charger Rust/Go/etc dans le PATH"
