#! /bin/bash
# Load .dirrc file with custom commands per directory

function load_dirrc() {
  if [[ -f '.dirrc' ]]
  then
    source .dirrc
  fi
}
chpwd_functions=(${chpwd_functions[@]} "load_dirrc")
