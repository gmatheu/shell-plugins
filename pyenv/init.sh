#! /bin/sh

command -v pyenv > /dev/null 2>&1 && {
  pyenva () {
    pyenv virtualenvs | fzf | tr -s ' ' | cut -f 2 -d ' ' | xargs -I{} pyenv activate {
  }
}

