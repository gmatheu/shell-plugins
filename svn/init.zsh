#! /usr/bin/zsh

function _svn_fomatted_log(){
  local limit="10"
  svn log --limit $limit |\
    perl -pe 's/\n/| /g => s/^-.*/\n/g' |\
    awk -F\| '{print "\033[33m"$1":" "\033[0m"$6 "\033[31m"$2 "\033[32m"$3}' |\
    sort |\
    tail -n $limit
}

alias sst='svn status'
alias svc='svn commit'
alias svu='svn update'
alias svi='svn info'
alias slo='svn log --limit 15'
alias slov='svn log --limit 15 -v'
alias slof=_svn_formatted_log
alias sei='svn propedit svn:ignore'

