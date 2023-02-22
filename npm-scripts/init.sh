#! /bin/sh
#
function _npm-scripts-inline { 
  npx json -f package.json scripts | npx json -e 'this.lines = Object.keys(this).map(l => { return `${l}|${this[l]}`})' lines | json -a 
}

function npm-run-scripts-find { 
  echo $(_npm-scripts-inline | fzf | cut -d '|' -f 1 )
}
function npm-run-scripts { 
  script=$(npm-run-scripts-find)
  echo "Executing -> ${script}"
  npx run ${script}
}
function npm-run-scripts-show { 
  echo $(_npm-scripts-inline | fzf | cut -d '|' -f 2)
}

alias npms=npm-run-scripts
alias npmss=npm-run-scripts-show
alias npmsf=npm-run-scripts-find
