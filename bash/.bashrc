# Function to display current Git branch in the prompt
# git_branch() {
#   local branch=$(git symbolic-ref HEAD 2> /dev/null || git describe --tags --always 2> /dev/null)
#   if [ -n "$branch" ]; then
#     branch=${branch#refs/heads/} # Remove refs/heads/ from the branch name
#     echo -e " (\033[38;5;9m${branch}\033[00m)"
#   fi
# }

# Simplified git_branch function that avoids complex logic
git_branch() {
  local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  [ -n "$branch" ] && echo " ($branch)"
}

# Custom PS1 with light blue for the user@host, color 215 for the directory, and the git branch
export PS1="\[\033[38;5;45m\]\u@\h\[\033[00m\] \[\033[38;5;215m\]\w\[\033[00m\]\$(git_branch) \$ "
# PS1="\$ "

# Simplified PS1 with proper non-printing character handling. Troubleshooting purposes
# export PS1="\[\033[01;32m\]\u@\h \[\033[01;34m\]\w\[\033[00m\]\$(git_branch) \$ "

# vi keys
set -o vi

# Load local bash configuration if it exists
if [ -f ~/.bash_local ]; then
    source ~/.bash_local
fi
