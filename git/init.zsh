#! /usr/bin/zsh

alias glo='git log --oneline --max-count=20 --reverse'
compdef _git glo=git-log
alias glof='git log --pretty=format:"%C(yellow)%h%Creset %s %Cred%an%Creset %Cgreen%ad" --max-count=30 --date=relative --reverse'
compdef _git glof=git-log
alias gstl='git stash && git pull --rebase'
alias gloc='git log --left-right --graph --cherry-pick --oneline -n 30'
compdef _git gloc=git-log
alias glog='git log --oneline --decorate --color --graph -n 30'
compdef _git glof=git-log
alias gap='git add -p'
compdef _git gap=git-add
function _git_recent_branches() {
  git for-each-ref --sort=-committerdate --count=5 --format='%(refname:short)' refs/heads/
}
alias grb='_git_recent_branches'

# Suffixes commit message with first part of branch name (delimited with _)
# Parameters
# $1 Message to concatenate
# $2 Files to commit
function _git_commit_with_branch_message() {
  git commit -m"$(git rev-parse --abbrev-ref HEAD | cut -d '_' -f 1): $1" $2
}
alias gcbm='_git_commit_with_branch_message'


function _git_show_remote() {
  remote=$1
  echo "New remote url for ${remote} is: $(git remote get-url ${remote})"
}

# Switches git remote url from ssh to https
# Parameters
# $1 remote name. origin by default
function git_remote_to_https(){
  remote=${1:-origin}
  git remote set-url ${remote} $(git remote get-url ${remote} | sed 's#:#/#; s#git@#https://#')
  _git_show_remote ${remote}
}

# Switches git remote url from https to ssh
# Parameters
# $1 remote name. origin by default
function git_remote_to_ssh(){
  remote=${1:-origin}
  git remote set-url ${remote} $(git remote get-url ${remote} | sed 's#https://\(.*\)/\([^/].*\)/#git@\1:\2/#')
  _git_show_remote ${remote}
}

# Toggles git remote url from https to ssh and backwards
# Parameters
# $1 remote name. origin by default
function git_switch_remote(){
  remote=${1:-origin}
  git remote get-url ${remote} | grep -q 'https' \
    && git_remote_to_ssh ${remote} \
    || git_remote_to_https ${remote}
}
alias grs=git_switch_remote
