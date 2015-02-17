#! /usr/bin/zsh

alias gsci='git svn create-ignore'
alias gssi='git svn show-ignore'

function git-svn-ignore(){
  git svn show-ignore > .git/info/exclude
}


