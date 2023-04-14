#! /bin/sh
## # npm scripts plugin
##
## Helper functions to fastly search and execute npm scripts
##
## Requires: fzf to provide fuzzy search

_npm-scripts-inline () { 
  stat package.json &> /dev/null || { echo "package.json not found" }
  npx json -f package.json scripts |\
    npx json -e 'this.lines = Object.keys(this).map(l => { return l + "|" + this[l]; })' lines |\
    json -a 
}

npm-run-scripts-find () { 
  ### Find and show script name
  echo $(_npm-scripts-inline | fzf) | cut -d '|' -f 1
}

npm-run-scripts () { 
  ### Find script and execute selected script. 
  ### If a yarn.lock is detected, uses yarn instead of npm
  script=$(npm-run-scripts-find)
  echo "Executing -> ${script}"
  print -s "npm run ${script}"
  cmd="npm"
  stat yarn.lock &> /dev/null && { cmd="yarn" }
  print -s "${cmd} run ${script}"
  ${cmd} run ${script}
}

npm-run-scripts-show () { 
  ### Find script and show its content
  echo $(_npm-scripts-inline | fzf) | cut -d '|' -f 2
}

alias npms=npm-run-scripts
alias npmss=npm-run-scripts-show
alias npmsf=npm-run-scripts-find
alias yarns=npm-run-scripts
alias yarnss=npm-run-scripts-show
alias yarnsf=npm-run-scripts-find
