#! /bin/bash
### # gcloud plugin
##
## Provides functions to search and execute actions of GCP resources
##
## Requires: 
##    * gcloud-sdk tools for faste access to different services.
##    * fzf and/or gum to provide fuzzy search

BKT_PREFIX=${BKT_PREFIX:-''}
if command -v bkt >&/dev/null; then
  _bkt() { 
    scope=${BKT_SCOPE:-};
    ttl=${BKT_TTL:-'6h'};
    stale=${BKT_STALE:-'4h'};
    addopts=${BKT_ADDOPTS:-};
    command ${BKT_PREFIX} bkt --discard-failures \
      --scope gcloud-shell-plugin_"${scope}" --ttl="${ttl}" --stale="${stale}" ${addopts} "$@"; 
    }
else
  # If bkt isn't installed skip its arguments and just execute directly.
  # Optionally write a msg to stderr suggesting users install bkt.
  _bkt() {
    while [[ "$1" == --* ]]; do shift; done
    "$@"
  }
fi

GCLOUD_PREFIX=${GCLOUD_PREFIX:-}
BECOME_PREFIX=${BECOME_PREFIX:-}
GCLOUD_CMD=${GCLOUD_CMD:-'gcloud'}

# Now you can call bkt (the function) just like you'd call bkt (the binary):
gcloud-configs () {
  ### Shows existing configurations (Actions: Enter to activate)
  cmd="${BECOME_PREFIX} ${GCLOUD_CMD} config configurations activate"
  _bkt -- "${GCLOUD_CMD}" config configurations list |\
    fzf --header=lines=1 --tac \
      --preview-window up:5 \
      --preview 'echo "<CR> to activate"' \
      --header='Keys => <CR> to activate' \
      --bind "enter:become(${cmd} {1})"
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
  project=$(_bkt -- gcloud config get-value project 2>/dev/null)
  # CACHE_FILE=/tmp/gcloud-compute-instances_${PROJECT}.txt
  # _make_cache "$CACHE_FILE" 'gcloud compute instances list'
  # cat "${CACHE_FILE}" | tr -s ' ' | fzf --bind 'ctrl-s:become(echo {} | cut -d " " -f 2 |\
  #   xargs -INAME echo gcloud compute instances start NAME)' | tr -s ' ' | cut -d ' ' -f 1,2 |\
  #   xargs -o -n 2 bash -x -c 'gcloud compute ssh --ssh-flag="-A -ttt" $0 --zone $1'

  BKT_TTL=20m BKT_STALE=15m _bkt -- gcloud compute instances list |\
    fzf --header=lines=1 --tac --header='Keys => <CR> to ssh / <ctrl-s/S> to start/stop' \
      --bind "ctrl-s:become(${GCLOUD_CMD} compute instances start {1})" \
      --bind "ctrl-S:become(${GCLOUD_CMD} compute instances stop {1})" \
      --bind "enter:become(${GCLOUD_CMD} compute ssh -ssh-flag'-A -ttt' {1})"
}
gcloud-containers-cluster-credentials () {
  gcloud container clusters list | fzf | tr -s ' ' | cut -d ' ' -f 1 | xargs -I{} gcloud container clusters get-credentials {}
}
alias gclouds=gcloud-sql-instances
alias gcloudi=gcloud-compute-instances
alias gcloudc=gcloud-configs

