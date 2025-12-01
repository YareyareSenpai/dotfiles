# Add user configurations here
# For HyDE to not touch your beloved configurations,
# we added 2 files to the project structure:
# 1. ~/.user.zsh - for customizing the shell related hyde configurations
# 2. ~/.zshenv - for updating the zsh environment variables handled by HyDE // this will be modified across updates

#  Plugins 
# oh-my-zsh plugins are loaded  in ~/.user.zsh file, see the file for more information

#  Startup 
# Smart ASCII/Logo display with randomized fetch
# Always run your preferred banner script

#  History & Logging 
# Robust persistent shell history across tabs and sessions
HISTFILE=~/.config/zsh/.histfile
HISTSIZE=5000
SAVEHIST=100000
setopt autocd extendedglob
unsetopt beep
bindkey -v

#  Aliases 
alias c='clear'
alias l='eza -lh --icons=auto'
alias ls='eza -1 --icons=auto'
alias ll='eza -lha --icons=auto --sort=name --group-directories-first'
alias ld='eza -lhD --icons=auto'
alias lt='eza --icons=auto --tree'
alias un='$aurhelper -Rns'
alias up='$aurhelper -Syu'
alias pl='$aurhelper -Qs'
alias pa='$aurhelper -Ss'
alias pc='$aurhelper -Sc'
alias po='$aurhelper -Qtdq | $aurhelper -Rns -'
alias vc='code'
alias fastfetch='fastfetch --logo-type kitty'
alias pavu='GDK_BACKEND=x11 pavucontrol'

#  Text Automation 
# Enable Zsh Completion System
autoload -Uz compinit && compinit
autoload -Uz predict-on && predict-on

# Activate Predictive Typing
bindkey '^P' predict-on            # Ctrl+P to toggle prediction
bindkey '^N' history-search-forward
bindkey '^R' history-incremental-search-backward

# Make history more useful
setopt HIST_IGNORE_DUPS      # Skip duplicate entries
setopt HIST_FIND_NO_DUPS     # Avoid repeating search results
setopt INC_APPEND_HISTORY    # Write history instantly

#  Plugins 
plugins=(
  "sudo"
  "git"
  "zsh-autosuggestions"
# "zsh-syntax-highlighting"
  "zsh-completions"
)

#  Colours 
### ┌── Dynamic Prompt Color ──────────────────────┐
# Setup: time-based color changes
autoload -U colors && colors
setopt PROMPT_SUBST
# Function: get_dynamic_color()
get_dynamic_color() {
  local hour=$(date +%H)
  if (( hour < 12 )); then
    echo "%F{yellow}"   # morning sunshine
  elif (( hour < 18 )); then
    echo "%F{blue}"     # midday sky
  else
    echo "%F{magenta}"  # evening glow
  fi
}
# Prompt uses: username@host + path ➤
PROMPT='$(get_dynamic_color)%n@%m %F{white}%~ %f➤ '
### └──────────────────────────────────────────────┘
autoload -U compinit
compinit

# Adding additional directories to search path
export PATH="$HOME/bin:$PATH"

#
