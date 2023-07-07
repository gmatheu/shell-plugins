### # zplug-helper plugin
##
## Provides for pass (password) password manager
##
## Requires: 
##    * fzf to provide fuzzy search
##    * xclip to clipboard management

pass-search () {
  ### Fuzzy searches all stored passwords (Actions: Enter to copy to clipboard / ctrl-\ to write to stdout)
  pass git ls-files | grep -v '.gpg-id' | sed -e 's/.gpg//' | fzf --bind 'ctrl-\:become(pass show {})' --bind 'enter:become(pass show {} | xclip -selection clipboard)'
}

function _pass-show() {
  command -v fzf > /dev/null 2>&1 
  has_fzf=$?

  if [ "$has_fzf" -eq "0" ];
  then
    pass show "$2" $(pass --plain --no-header | fzf)
  else
    pass show ""$"2" "$1"
  fi
}

function _pass-show-clip() {
  _pass-show "$1" '--clip'
}

function _pass-show-xclip() {
  _pass-show "$1" | xclip -selection clipboard
}

alias pss=pass-search
alias psc=_pass-show-clip
alias psx=_pass-show-xclip
alias pso=_pass-show
