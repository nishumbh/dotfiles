export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="gallifrey"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# -------------------------- 
# PATH ADDITIONS
# -------------------------- 

export PNPM_HOME="/home/nish/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
export PATH="$HOME/.local/bin:$PATH"
export PATH=/usr/local/cuda-13.0/bin:$PATH


# -------------------------- 
# API KEYS & EXPORTS
# --------------------------

[ -f ~/.secrets ] && source ~/.secrets
export NLTK_DATA="$HOME/.local/share/nltk_data" 
export JAVA_HOME="/usr/lib/jvm/java-21-openjdk"


# -------------------------- 
# ALIASES 
# -------------------------- 

alias projects="cd ~/dev/projects/"
alias temp="cd ~/dev/temp/"
alias docs="cd ~/dev/docs/"
[[ "$TERM" == "xterm-kitty" ]] && alias ssh="TERM=xterm-256color ssh"

# -------------------------- 
# SSH SIGNING FOR GITHUB
# -------------------------- 

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

