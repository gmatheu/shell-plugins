#! /bin/bash
### # gcloud plugin
##
## Provides for pass (password) password manager
##
## Requires: 
##    * gcloud-sdk tools for faste access to different services.
##    * fzf and/or gum to provide fuzzy search

command -v gcloud > /dev/null 2>&1 && {
  gcloud-configs () {
    ### Shows existing configurations (Actions: Enter to activate)
    gcloud config configurations list | fzf | tr -s ' ' | cut -d ' ' -f 1 | xargs -I{} gcloud config configurations activate {}
  }
  gcloud-sql-instances () {
    ### Shows existing sql instances (Actions: Enter to activate)
    gcloud sql instances list | tac | fzf | tr -s ' ' | cut -d ' ' -f 1 | xargs -I{} gcloud sql connect {}
  }

  _make_cache() {
    CACHE_FILE=$1
    CMD=$2
    if [ ! -z "${NO_CACHE}" ]
    then
      echo "Removing cache file"
      rm -f ${CACHE_FILE}
    fi
    if [ ! -f ${CACHE_FILE} ]
    then
      echo "Caching ${CMD} output to ${CACHE_FILE}"
      eval $(echo ${CMD}) | tac | tee ${CACHE_FILE}
    else
      echo "Using cached: ${CACHE_FILE}"
    fi
  }
_current_project() {
  echo gcloud config get-value project 2>/dev/null
}
  gcloud-compute-instances () {
    ### Shows existing compute engine instances (Actions: Enter to ssh-in)
    PROJECT=$(gcloud config get-value project 2>/dev/null)
    CACHE_FILE=/tmp/gcloud-compute-instances_${PROJECT}.txt
    _make_cache "$CACHE_FILE" 'gcloud compute instances list'
    cat "${CACHE_FILE}" | tr -s ' ' | fzf --bind 'ctrl-s:become(echo {} | cut -d " " -f 2 | xargs -INAME echo gcloud compute instances start NAME)' | tr -s ' ' | cut -d ' ' -f 1,2 | xargs -o -n 2 bash -x -c 'gcloud compute ssh --ssh-flag="-A -ttt" $0 --zone $1'
  }
  gcloud-containers-cluster-credentials () {
    gcloud container clusters list | fzf | tr -s ' ' | cut -d ' ' -f 1 | xargs -I{} gcloud container clusters get-credentials {}
  }
  alias gclouds=gcloud-sql-instances
  alias gcloudi=gcloud-compute-instances
  alias gcloudc=gcloud-configs
}

