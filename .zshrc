# Paths Start

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

export PATH="$PATH:$HOME/.cargo/bin"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

#go
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:"$HOME//go/bin"


# Correct path for Arch Linux
export JAVA_HOME=/usr/lib/jvm/default
export PATH=$JAVA_HOME/bin:$PATH

# Ensure Android SDK is set (CachyOS usually puts this in home)
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin

# Paths End



# ===== Zinit Setup =====
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Install Zinit if missing
if [[ ! -d "$ZINIT_HOME" ]]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# ===== Theme & Appearance =====
# oh-my-posh with custom theme
eval "$(oh-my-posh init zsh --config ~/.themes/oh-my-posh/themes/2.omp.json)"


# ===== Core Plugins =====
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-syntax-highlighting


# ===== Development Tools =====
# JavaScript/Node ecosystem
zinit light lukechilds/zsh-nvm
zinit light jsahlen/tmux-vim-integration.plugin.zsh
zinit snippet OMZP::yarn
zinit snippet OMZP::bun

# Python
zinit light pyenv/pyenv
zinit light davidparsson/zsh-pyenv-lazy


zinit wait"0" lucid for \
    OMZP::docker \
    OMZP::docker-compose \
    OMZP::kubectl \
    OMZP::helm \
    OMZP::terraform \
    OMZP::postgres \
    OMZP::mongocli \
    OMZP::archlinux



# ===== System & Productivity =====
# Fedora specific
zinit snippet OMZP::archlinux



# Git enhancements
zinit light wfxr/forgit
zinit snippet OMZP::git-extras

# Terminal utilities
zinit light b4b4r07/enhancd
zinit light urbainvaes/fzf-marks
zinit light joshskidmore/zsh-fzf-history-search

# Editor integration
zinit snippet OMZP::vi-mode
zinit light jeffreytse/zsh-vi-mode


# Load completions
autoload -Uz compinit && compinit -C

zinit cdreplay -q

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups



# ===== zsh-syntax-highlighting Custom Colors =====
# Make keywords, builtins, etc. more pastel/light

# Commands
ZSH_HIGHLIGHT_STYLES[command]='fg=#a6e3a1'        # light green
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#89b4fa'        # light blue
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#fab387'  # peach
ZSH_HIGHLIGHT_STYLES[alias]='fg=#f9e2af'          # soft yellow

# Strings & paths
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#f2cdcd'  # soft pink
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#f5c2e7'  # lighter pink
ZSH_HIGHLIGHT_STYLES[path]='fg=#94e2d5'                    # teal

# Options & parameters
ZSH_HIGHLIGHT_STYLES[option]='fg=#cba6f7'          # lavender
ZSH_HIGHLIGHT_STYLES[parameter]='fg=#f38ba8'       # rose

# Errors
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#f38ba8,bold' # red/pink bold
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#a6adc8'   # grayish


# ===== Autosuggestions Color =====
# Make suggestion text more visible (default is too dark gray)

# Light pastel gray-blue (easy to read on dark background):
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#7aa2f7'

# Or soft white:
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#c0caf5'

# Or bold + underlined variant:
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#c0caf5,underline'


# ===== Dependency Checker =====
# List of all external tools your config relies on
local required_cmds=(
    fzf
    zoxide
    oh-my-posh
    eza
    bat
    rg
    duf
)

# Loop through and warn if any are missing
for cmd in "${required_cmds[@]}"; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo -e "\e[31m[!] Warning:\e[0m Missing dependency '\e[33m$cmd\e[0m'. Some aliases or features may not work."
    fi
done

# ===== Aliases & Functions =====
# System 
alias ls='eza --group-directories-first --icons'
alias ll='eza -lh --group-directories-first --icons'
alias la='eza -lah --group-directories-first --icons'
alias cat='bat --style=plain'
alias grep='rg --color=auto'
alias df='duf'
alias dnf='sudo dnf'
alias upgrade='sudo dnf upgrade --refresh && flatpak update'
alias c ='clear'
alias q='exit'


alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'

# Listing files (eza)
alias l='eza -1 --group-directories-first --icons'  # Single column
alias lt='eza --tree --level=2 --group-directories-first --icons'  # Tree view
alias lta='eza --tree --level=2 --all --group-directories-first --icons'  # Tree view (hidden files)
alias lx='eza -lh --sort=ext --group-directories-first --icons'  # Sort by extension
alias lk='eza -lh --sort=size -r --group-directories-first --icons'  # Sort by size (largest first)
alias lm='eza -lh --sort=modified -r --group-directories-first --icons'  # Sort by modified time (newest first)

# Disk usage
alias du='du -h'
alias dus='du -sh * | sort -h'  # Human-readable, sorted by size
alias dfh='df -h'  # Human-readable disk free

# Process management
alias psa='ps aux'
alias psg='ps aux | grep -v grep | grep -i'  # Search processes (e.g., `psg nginx`)
alias killp='kill -9'  # Force kill process by PID

# System info
alias cpu='top -o cpu'  # Show processes by CPU usage
alias mem='top -o rsize'  # Show processes by memory usage
alias ip='ip -color=auto'  # Colorized IP command
alias ips='ip -brief addr show'  # Show all IP addresses
alias pubip='curl ifconfig.me'  # Get public IP


# Git
alias gs='git status'
alias gc='git commit'
alias gco='git checkout'
alias gd='git diff'
alias ga='git add'
alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset"'
alias gb='git branch'
alias gba='git branch -a'  # All branches (local + remote)
alias gbd='git branch -d'  # Delete branch
alias gbD='git branch -D'  # Force delete branch
alias gcm='git checkout main || git checkout master'  # Switch to main/master
alias gps='git push'
alias gpf='git push --force-with-lease'  # Safer force push
alias gpl='git pull'
alias gr='git remote -v'  # Show remotes
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias gst='git stash'
alias gstp='git stash pop'
alias gsw='git switch'
alias gswc='git switch -c'  # Create and switch to new branch
alias gitsafe='git config --global --add safe.directory'    # Mark a repo as safe
alias gitsafehere='git config --global --add safe.directory "$PWD"'    # Mark current directory as safe
alias gitsafes='git config --get-all safe.directory'    # Check all safe directories
alias gitunsafe='git config --global --unset safe.directory'    # Remove a repo from safe directories



# Docker
alias dcu='docker compose up -d'
alias dcd='docker compose down'
alias dcl='docker compose logs -f'
alias dps='docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dpsa='docker ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dimg='docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.ID}}\t{{.Size}}"'
alias dstop='docker stop $(docker ps -aq)'  
alias drm='docker rm $(docker ps -aq)'  
alias drmi='docker rmi $(docker images -q)'  
alias dprune='docker system prune -af'  

# Podman (if you use it on Fedora)
alias pps='podman ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias ppsa='podman ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"'


# Python aliases
alias py='python3'
alias python='python3'
alias pip='pip3'
alias pipu='pip3 list --outdated --format=freeze | grep -v "^\-e" | cut -d = -f 1 | xargs -n1 pip3 install -U'  # Update all pip packages
alias venv='python3 -m venv .venv && source .venv/bin/activate'  # Create and activate venv
alias activate='source .venv/bin/activate'  # Quick venv activation


# DNF (Fedora package manager)
alias dnfl='sudo dnf list installed' 
alias dnfs='sudo dnf search'  
alias dnfi='sudo dnf install' 
alias dnfu='sudo dnf upgrade' 
alias dnfr='sudo dnf remove'  
alias dnfc='sudo dnf clean all'  

# Clipboard (requires `xclip` or `wl-copy` on Wayland)
alias pbcopy='xclip -selection clipboard'  # Copy to clipboard (e.g., `cat file.txt | pbcopy`)
alias pbpaste='xclip -selection clipboard -o'  # Paste from clipboard

# Network
alias ping='ping -c 5'  # Ping 5 times by default
alias ports='sudo ss -tulnp'  # Show listening ports
alias http='python3 -m http.server'  # Start HTTP server (port 8000)

# Safety nets
alias rm='rm -i'  # Confirm before deleting
alias mv='mv -i'  # Confirm before overwriting
alias cp='cp -i'  # Confirm before overwriting
alias ln='ln -i'  # Confirm before overwriting

# Fun
alias starwars='telnet towel.blinkenlights.nl'  # Watch Star Wars in terminal
alias cheat='curl cheat.sh'  # Quick cheatsheets (e.g., `cheat tar`)



# ===== Shell Integrations =====
# FZF configuration
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --preview-window=right:60%'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Zoxide (smarter cd)
eval "$(zoxide init zsh --cmd j)"


# System info - only show if interactive and command exists
 if [[ $- == *i* ]] && command -v fastfetch >/dev/null; then
     fastfetch
 fi





# bun completions
[ -s "/home/fiamanillah/.bun/_bun" ] && source "/home/fiamanillah/.bun/_bun"


