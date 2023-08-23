#! /bin/sh
### # clipboard plugin
##
## Functions to manage clipboard
##
## Requires: 
##    * xclip 

command -v xclip > /dev/null 2>&1 && {

xclip_full_path() {
  ### Shows and copies to clipboard full path of given file
  _filename=$1
  _path=$(realpath "${_filename}")
  echo "${_path}"
  echo "${_path}" | xclip -selection clipboard
}

alias xc='xclip -selection clipboard'
alias xp=xclip_full_path
alias xs='xclip -selection secondary'
alias xo='xclip -o'
alias xoc='xclip -o -selection clipboard'
alias xos='xclip -o -selection secondary'
}

command -v pbcopy > /dev/null 2>&1 && {
  alias xc='pbcopy'
  alias xo='pbpaste'
}
