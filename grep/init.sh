#! /bin/bash

# Grep aliases
function grep-aliases() {
  alias | grep $1
}

# Grep rails routes
function grep-rails-routes() {
 	rake routes | grep $1
}

function grep-recursive(){
  grep -R -e $1 .
}
alias grr="grep-recursive"

alias ga="grep-aliases"
alias rrg="grep-rails-routes"
alias rt="rake -T"
alias psg="ps aux | grep $@"
