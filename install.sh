#!/usr/bin/env bash
set -e

# ==========================================
# CONSTANTS & COLORS
# ==========================================
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
CONFIG_DIR="$HOME/.config"

ORANGE='\033[38;2;255;152;0m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

info() { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
warn() { echo -e "${ORANGE}[WARNING]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

# ==========================================
# 1. DEVICE SELECTION
# ==========================================
echo -e "${ORANGE}"
cat << "EOF"
  ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗ 
 ██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝ 
 ██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗
 ██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║
 ╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝
  ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝ 
EOF
echo -e "${NC}"
echo "Select the target deployment environment:"
echo "1) Laptop (Acer Predator - Enables eDP-1 monitor, brightness controls, battery modules)"
echo "2) Desktop (Office PC - Standard display output, disables auto-sleep dimming)"
read -p "Enter choice [1-2]: " device_choice

case $device_choice in
    1) IS_LAPTOP=true ;;
    2) IS_LAPTOP=false ;;
    *) error "Invalid selection. Exiting." ;;
esac

# ==========================================
# 2. SYSTEM UPDATE & DEPENDENCIES
# ==========================================
info "Updating CachyOS and installing dependencies..."
sudo pacman -Syu --noconfirm

# Core packages based on your dotfiles
PACKAGES=(
    zsh kitty neovim git curl wget fastfetch stow
    rofi-wayland wlogout swappy cliphist wl-clipboard
    eza bat ripgrep fzf zoxide fd ttf-cascadia-code-nerd noto-fonts
    hyprland hyprlock hypridle swww python-pip npm unzip
    playerctl btop pulsemixer oh-my-posh
)

# Laptop specific packages
if [ "$IS_LAPTOP" = true ]; then
    PACKAGES+=(brightnessctl powerprofilesctl)
fi

# Install via pacman (assuming CachyOS repos have most of these)
for pkg in "${PACKAGES[@]}"; do
    if ! pacman -Qs "$pkg" > /dev/null; then
        sudo pacman -S --noconfirm "$pkg" || warn "Failed to install $pkg via pacman. You may need an AUR helper."
    fi
done

# Install pyprland (usually available via AUR or pip)
if ! command -v pypr &> /dev/null; then
    info "Installing Pyprland..."
    pip install --user pyprland || warn "Please install pyprland manually using yay/paru."
fi

# ==========================================
# 3. BACKUP EXISTING CONFIGS
# ==========================================
info "Creating backup of existing configurations in $BACKUP_DIR..."
mkdir -p "$BACKUP_DIR"

CONFIGS_TO_BACKUP=(
    "kitty" "wlogout" "swappy" "rofi" "pypr" "nvim"
    "hyprpanel" "hypr" "fastfetch"
)

for conf in "${CONFIGS_TO_BACKUP[@]}"; do
    if [ -d "$CONFIG_DIR/$conf" ]; then
        cp -r "$CONFIG_DIR/$conf" "$BACKUP_DIR/"
        rm -rf "$CONFIG_DIR/$conf"
    fi
done

if [ -f "$HOME/.zshrc" ]; then
    cp "$HOME/.zshrc" "$BACKUP_DIR/"
fi
if [ -f "$HOME/.gitconfig" ]; then
    cp "$HOME/.gitconfig" "$BACKUP_DIR/"
fi

success "Backup completed."

# ==========================================
# 4. DEPLOY DOTFILES
# ==========================================
info "Deploying new configurations..."

mkdir -p "$CONFIG_DIR"

# Copy directories inside config/
if [ -d "$DOTFILES_DIR/config" ]; then
    cp -r "$DOTFILES_DIR/config/"* "$CONFIG_DIR/"
else
    warn "Config folder not found in the current directory. Make sure you run this script from inside dotfiles-main."
fi

# Copy home files
cp "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc" 2>/dev/null || true
cp "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig" 2>/dev/null || true

# Ensure script permissions
find "$CONFIG_DIR/hypr/scripts" -type f -iname "*.sh" -exec chmod +x {} \;

# ==========================================
# 5. DEVICE-SPECIFIC CONFIGURATION
# ==========================================
info "Applying device-specific tweaks..."

MONITOR_CONF="$CONFIG_DIR/hypr/monitors.conf"

if [ "$IS_LAPTOP" = true ]; then
    info "Setting up Laptop Monitor (eDP-1 at 165Hz)..."
    cat << EOF > "$MONITOR_CONF"
# Laptop Monitor Configuration
monitor=eDP-1,1920x1200@165.0,0x0,1.0
# Auto-detect external monitors
monitor=,preferred,auto,1,mirror,eDP-1
EOF
else
    info "Setting up Desktop Monitor..."
    cat << EOF > "$MONITOR_CONF"
# Desktop Monitor Configuration
monitor=,preferred,auto,1
EOF
    
    # Optional: Disable extreme auto-sleep dimming on desktop
    HYPRIDLE_CONF="$CONFIG_DIR/hypr/hypridle.conf"
    if [ -f "$HYPRIDLE_CONF" ]; then
        sed -i 's/timeout = 3450/# timeout = 3450/g' "$HYPRIDLE_CONF"
        sed -i 's/on-timeout = brightnessctl/# on-timeout = brightnessctl/g' "$HYPRIDLE_CONF"
    fi
fi

# ==========================================
# 6. SHELL & PLUGINS SETUP
# ==========================================
info "Setting up Zsh and Oh-My-Posh..."

# Change default shell
if [ "$SHELL" != "/usr/bin/zsh" ]; then
    chsh -s /usr/bin/zsh
    success "Changed default shell to Zsh."
fi

# Create oh-my-posh theme directory if it doesn't exist
mkdir -p "$HOME/.themes/oh-my-posh/themes/"
# Note: You will need to ensure 2.omp.json is placed in this directory manually if it's not in the repo.

# Zinit will automatically install itself upon opening Zsh for the first time
# based on the logic currently within your .zshrc file.

success "Installation complete! Please restart your session or type 'Hyprland' to load the new environment."