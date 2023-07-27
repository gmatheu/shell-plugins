#! /bin/bash
### # password-store plugin
##
## Provides for pass (password) password manager
##
## Requires: 
##    * pass (password-store) with passwords 
##    * fzf to provide fuzzy search
##    * xclip to clipboard management

pass-search () {
  ### Fuzzy searches all stored passwords (Actions: Enter to copy to clipboard / ctrl-\ to write to stdout)
  pass git ls-files |\
    grep -v '.gpg-id' |\
    sed -e 's/.gpg//' |\
    fzf --bind 'ctrl-\:become(pass show {})' \
        --bind 'enter:become(pass show {} | xclip -selection clipboard)' \
        --preview 'echo "<CR> to copy to clipboard \n<c-\> to show password"' \
        --header='Keys => <CR> to copy to clipboard \n<c-\> to show password' 
}

alias pss=pass-search
alias psc=pass-search
