# Simplified git_branch function that avoids complex logic
# git_branch() {
#   local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
#   [ -n "$branch" ] && echo "($branch)"
# }

git_branch() {
  if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [ -n "$branch" ]; then
      echo " ($branch)"
    fi
  fi
}

# ANSII Colors
export blue="\[\033[38;5;45m\]"
export orange="\[\033[38;5;137m\]"
# export orange="\[\033[33m\]"  # Yellow (standard ANSI color)
# export orange="\[\033[38;5;215m\]"
export red="\[\033[38;5;9m\]"
export reset="\[\033[00m\]"
# Custom PS1 with light blue for the user@host, color 215 for the directory, and the git branch
# export PS1="${blue}\u@\h${reset} ${orange}\w${reset}$(git_branch)${reset}\$ "
export PS1="\[\033[38;5;45m\]\u@\h\[\033[00m\] \[\033[38;5;180m\]\w\[\033[00m\]\$(git_branch) \$ "

# Simplified PS1 with proper non-printing character handling. Troubleshooting purposes
# export PS1="\[\033[01;32m\]\u@\h \[\033[01;34m\]\w\[\033[00m\]\$(git_branch) \$ "

# vi keys
set -o vi

# Load local bash configuration if it exists
if [ -f ~/.bash_local ]; then
    source ~/.bash_local
fi

alias l="ls -al"
alias ll="ls -al"

export ADAPTER_IP=$(ip addr show $ADAPTER_NAME | grep -E "inet " | awk '{print $2}' | awk -F '/' '{print $1}')

mkcd() {
  mkdir -p -- "$1" && cd -- "$1"
}
