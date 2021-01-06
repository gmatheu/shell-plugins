#! /bin/sh

command -v gcloud > /dev/null 2>&1 && {
  gcloud-configurations () {
    gcloud config configurations list | fzf | tr -s ' ' | cut -d ' ' -f 1 | xargs -I{} gcloud config configurations activate {}
  }
}

