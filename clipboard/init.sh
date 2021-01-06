#! /bin/sh

command -v xclip > /dev/null 2>&1 && {
  alias xc='xclip -selection clipboard'
  alias xp='xclip'
  alias xs='xclip -selection secondary'
  alias xo='xclip -o'
  alias xoc='xclip -o -selection clipboard'
  alias xos='xclip -o -selection secondary'
}

command -v pbcopy > /dev/null 2>&1 && {
  alias xc='pbcopy'
  alias xo='pbpaste'
}
