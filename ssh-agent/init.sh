#! /bin/bash
## # ssh-agent plugin
##
## Provides several functions and aliases to manage a single instance of a ssh-agent across
## multiple terminal instances.
##
## Requires: fzf and/or gum to provide fuzzy search

SSH_AGENT_DEFAULT_ALIAS='default'
SSH_AGENT_MUTEX_HOME=${HOME}
SSH_AGENT_MUTEX=${SSH_AGENT_MUTEX_HOME}/.current_ssh_agent
SSH_AGENT_IDENTITIES=${SSH_AGENT_MUTEX_HOME}/.current_ssh_agent_identities
SSH_AGENT_ACTIVE=${SSH_AGENT_MUTEX_HOME}/.active_ssh_agent
SSH_HOME=$HOME/.ssh

ssh_agent_list_identities() {
  echo "> Loaded Identities"
  ssh-add -l
}

_ssh_agent_save_identities() {
  identity=$1
  local identities_file
  identities_file="$SSH_AGENT_IDENTITIES.$(cat "${SSH_AGENT_ACTIVE}")"
  echo "$identity" >>"$identities_file"
  local content
  content=$(cat ${identities_file} | sort | uniq)
  echo "$content" >"$identities_file"
}

_ssh_agent_clear_identities() {
  identities_file="$SSH_AGENT_IDENTITIES.$(cat "${SSH_AGENT_ACTIVE}")"
  truncate -f -s 0 "$identities_file"
}
_ssh_agent_restore_identities() {
  identities_file="$SSH_AGENT_IDENTITIES.$(cat "${SSH_AGENT_ACTIVE}")"
  echo "Restoring identities"
  for identity in $(cat "$identities_file"); do
    ssh-add "$identity"
  done
}

ssh_agent_activate_current() {
  ### Activates the current ssh agent.
  alias=${1:-${SSH_AGENT_DEFAULT_ALIAS}}
  echo "Activating ${alias} ssh-agent: $SSH_AGENT_PID"
  source $SSH_AGENT_MUTEX.${alias}
  echo "${alias}" >"$SSH_AGENT_ACTIVE"

  ssh-add -l >/dev/null 2>&1
  ret=$?
  if [ $ret -ne 2 ]; then
    ssh_agent_list_identities
  else
    echo "Agent not loaded"
    ssh_agent_create "${alias}"
  fi
}
ssh_agent_activate_interactive() {
  # ssh_agent_list | gum choose | xargs -o -I {} ssh_agent_activate_current {}
  ssh_agent_activate_current $(ssh_agent_list | fzf)
}

ssh_agent_list() {
  ### List existing agents
  find "${SSH_AGENT_MUTEX_HOME}" -maxdepth 1 -name '.current_ssh_agent.*' | cut -d '.' -f 3
}

ssh_agent_create() {
  ### Creates a new ssh-agent and store its environment variables into $SSH_AGENT_MUTEX
  alias=${1:-${SSH_AGENT_DEFAULT_ALIAS}}
  ssh-agent >"$SSH_AGENT_MUTEX.${alias}"
  ssh_agent_activate_current "${alias}"
  echo "${alias} ssh-agent created: $SSH_AGENT_PID"
}

ssh_agent_kill_current() {
  ### Kills current ssh agent.
  echo "Killing current ssh agent: $SSH_AGENT_PID"
  kill -9 "$SSH_AGENT_PID"
  grep -n -e "$SSH_AGENT_PID" ${SSH_AGENT_MUTEX}.* | cut -d ':' -f 1 | xargs -i{} echo rm {} \;
  unset "$SSH_AGENT_PID"
}

ssh_agent_add_identities() {
  ssh_agent_list_identities
  echo "------------"
  for identity in $(find "$SSH_HOME" -type f -not -name '*.pub' -not -name 'known_*' -printf '%f\n' | gum choose --no-limit); do
    ssh-add "$SSH_HOME/$identity"
    _ssh_agent_save_identities "$SSH_HOME/$identity"
  done
}

ssh_agent_add_identity() {
  ssh_agent_list_identities
  echo "------------"
  for identity in $(find "$SSH_HOME"/ -type f -not -name '*.pub' -not -name 'known_*' -printf '%f\n' | fzf); do
    ssh-add "$SSH_HOME/$identity"
    _ssh_agent_save_identities "$SSH_HOME/$identity"
  done
}

alias ssh-agent-create=ssh_agent_create
alias sac=ssh_agent_activate_current
alias sacr=_ssh_agent_restore_identities
alias sacc=_ssh_agent_clear_identities
alias saci=ssh_agent_activate_interactive
alias sal=ssh_agent_list_identities
alias saa=ssh_agent_add_identity
alias sas=ssh_agent_add_identities
alias sad=ssh_agent_remove_identity
