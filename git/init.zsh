#! /usr/bin/zsh

alias glo='git log --oneline --max-count=20 --reverse'
compdef _git glo=git-log
alias glof='git log --pretty=format:"%C(yellow)%h%Creset %s %Cred%an%Creset %Cgreen%ad" --max-count=15 --date=relative --reverse'
compdef _git glof=git-log
alias gstl='git stash && git pull --rebase'
alias gloc='git log --left-right --graph --cherry-pick --oneline'
compdef _git gloc=git-log
alias gap='git add -p'
compdef _git gap=git-add
