# Function to display current Git branch in the prompt
git_branch() {
  local branch
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ ! $branch == "HEAD" ]]; then
      echo -e " (\033[38;5;9m$branch\033[00m)"
    else
      echo -e " detached"
    fi
  fi
}
# Custom PS1 with light blue for the user@host, color 215 for the directory, and bright red for the Git branch
export PS1="\[\033[38;5;45m\]\u@\h\[\033[00m\] \[\033[38;5;215m\]\w\[\033[00m\]\$(git_branch) \$ "

# export PS1="\[\033[01;96m\]\u\[\033[38;5;14m\]@\h \[\033[38;5;14m\]\w\[\033[00m\]\$(git_branch) \$ "

# vi keys
set -o vi

# Load local bash configuration if it exists
if [ -f ~/.bash_local ]; then
    source ~/.bash_local
fi
