#! /bin/bash

function notify() {
  local result=$?
  if which notify-send &> /dev/null; then
    local name=${1}
    if test $result -eq 0; then
      local notification="Succeeded"
      notify-send -t 1000 -i dialog-ok "${name} ${notification}"
    else
      local notification="Failed"
      notify-send -t 3000 -i dialog-error "${name} ${notification}"
    fi
  fi
}
alias n=notify

