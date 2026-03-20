# Locale Settings (Fixes font/icon width rendering bugs in Kitty)
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Paths Start

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

export PATH="$PATH:$HOME/.cargo/bin"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

#go
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:"$HOME/go/bin"

# Correct path for Arch Linux
export JAVA_HOME=/usr/lib/jvm/default
export PATH=$JAVA_HOME/bin:$PATH

# Ensure Android SDK is set
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
# oh-my-posh cached loading
mkdir -p ~/.cache/zsh
if [[ ! -f ~/.cache/zsh/omp.zsh ]]; then
    oh-my-posh init zsh --config ~/.themes/oh-my-posh/themes/2.omp.json > ~/.cache/zsh/omp.zsh
fi
source ~/.cache/zsh/omp.zsh


# ===== Core Plugins =====
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab


# ===== Development Tools =====
# JavaScript/Node ecosystem
export NVM_LAZY_LOAD=true     # <--- Forces zsh-nvm to lazy load
zinit light lukechilds/zsh-nvm
zinit light jsahlen/tmux-vim-integration.plugin.zsh

# Defer heavier OMZP snippets so they don't block the prompt
zinit ice wait"0" lucid
zinit snippet OMZP::yarn

zinit ice wait"0" lucid
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
zinit snippet OMZP::archlinux

# Git enhancements
zinit light wfxr/forgit
zinit snippet OMZP::git-extras

# Terminal utilities
zinit light b4b4r07/enhancd
zinit light urbainvaes/fzf-marks
zinit light joshskidmore/zsh-fzf-history-search

# Editor integration (Removed OMZP::vi-mode to prevent conflicts)
zinit light jeffreytse/zsh-vi-mode


# Load completions
autoload -Uz compinit && compinit -C

zinit cdreplay -q

# MUST BE LOADED LAST (Fixes ghost character bug)
zinit light zsh-users/zsh-syntax-highlighting

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

ZSH_HIGHLIGHT_STYLES[command]='fg=#a6e3a1'        
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#89b4fa'        
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#fab387'  
ZSH_HIGHLIGHT_STYLES[alias]='fg=#f9e2af'          
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#f2cdcd'  
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#f5c2e7'  
ZSH_HIGHLIGHT_STYLES[path]='fg=#94e2d5'                    
ZSH_HIGHLIGHT_STYLES[option]='fg=#cba6f7'          
ZSH_HIGHLIGHT_STYLES[parameter]='fg=#f38ba8'       
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#f38ba8,bold' 
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#a6adc8'   

# ===== Autosuggestions Color =====
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#7aa2f7'

# ===== Dependency Checker =====
check_deps() {
    local required_cmds=(
        fzf zoxide oh-my-posh eza bat rg duf
    )
    for cmd in "${required_cmds[@]}"; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            echo -e "\e[31m[!] Warning:\e[0m Missing dependency '\e[33m$cmd\e[0m'."
        fi
    done
}


# ===== Aliases & Functions =====
alias ls='eza --group-directories-first --icons'
alias ll='eza -lh --group-directories-first --icons'
alias la='eza -lah --group-directories-first --icons'
alias cat='bat --style=plain'
alias grep='rg --color=auto'
alias df='duf'
alias dnf='sudo dnf'
alias upgrade='sudo dnf upgrade --refresh && flatpak update'
alias c='clear'
alias q='exit'
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'

alias l='eza -1 --group-directories-first --icons' 
alias lt='eza --tree --level=2 --group-directories-first --icons'  
alias lta='eza --tree --level=2 --all --group-directories-first --icons'  
alias lx='eza -lh --sort=ext --group-directories-first --icons'  
alias lk='eza -lh --sort=size -r --group-directories-first --icons'  
alias lm='eza -lh --sort=modified -r --group-directories-first --icons'  

alias du='du -h'
alias dus='du -sh * | sort -h'  
alias dfh='df -h'  

alias psa='ps aux'
alias psg='ps aux | grep -v grep | grep -i'  
alias killp='kill -9'  

alias cpu='top -o cpu'  
alias mem='top -o rsize'  
alias ip='ip -color=auto'  
alias ips='ip -brief addr show'  
alias pubip='curl ifconfig.me'  

alias gs='git status'
alias gc='git commit'
alias gco='git checkout'
alias gd='git diff'
alias ga='git add'
alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset"'
alias gb='git branch'
alias gba='git branch -a'  
alias gbd='git branch -d'  
alias gbD='git branch -D'  
alias gcm='git checkout main || git checkout master'  
alias gps='git push'
alias gpf='git push --force-with-lease'  
alias gpl='git pull'
alias gr='git remote -v'  
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias gst='git stash'
alias gstp='git stash pop'
alias gsw='git switch'
alias gswc='git switch -c'  
alias gitsafe='git config --global --add safe.directory'    
alias gitsafehere='git config --global --add safe.directory "$PWD"'    
alias gitsafes='git config --get-all safe.directory'    
alias gitunsafe='git config --global --unset safe.directory'    

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

alias pps='podman ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias ppsa='podman ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"'

alias py='python3'
alias python='python3'
alias pip='pip3'
alias pipu='pip3 list --outdated --format=freeze | grep -v "^\-e" | cut -d = -f 1 | xargs -n1 pip3 install -U'  
alias venv='python3 -m venv .venv && source .venv/bin/activate'  
alias activate='source .venv/bin/activate'  

alias dnfl='sudo dnf list installed' 
alias dnfs='sudo dnf search'  
alias dnfi='sudo dnf install' 
alias dnfu='sudo dnf upgrade' 
alias dnfr='sudo dnf remove'  
alias dnfc='sudo dnf clean all'  

alias pbcopy='xclip -selection clipboard'  
alias pbpaste='xclip -selection clipboard -o'  

alias ping='ping -c 5'  
alias ports='sudo ss -tulnp'  
alias http='python3 -m http.server'  

alias rm='rm -i'  
alias mv='mv -i'  
alias cp='cp -i'  
alias ln='ln -i'  

alias starwars='telnet towel.blinkenlights.nl'  
alias cheat='curl cheat.sh'  

# ===== Shell Integrations =====
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --preview-window=right:60%'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Zoxide cached loading
if [[ ! -f ~/.cache/zsh/zoxide.zsh ]]; then
    zoxide init zsh --cmd j > ~/.cache/zsh/zoxide.zsh
fi
source ~/.cache/zsh/zoxide.zsh

# System info (Commented out for speed. Uncomment if you want fastfetch back)
 if [[ $- == *i* ]] && command -v fastfetch >/dev/null; then
     fastfetch
 fi

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
