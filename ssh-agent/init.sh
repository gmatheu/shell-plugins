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
SSH_HOME=$HOME/.ssh

ssh_agent_list_identities() {
  echo "> Loaded Identities"
  ssh-add -l
}

ssh_agent_activate_current() {
  ### Activates the current ssh agent.
  alias=${1:-${SSH_AGENT_DEFAULT_ALIAS}}
  echo "Activating ${alias} ssh-agent: $SSH_AGENT_PID"
  source $SSH_AGENT_MUTEX.${alias}

  ssh_agent_list_identities
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
  find "$SSH_HOME" -type f -not -name '*.pub' -not -name 'known_*' -printf '%f\n' | gum choose --no-limit | xargs -o -I {} ssh-add "$SSH_HOME"/{}
}

ssh_agent_add_identity() {
  ssh_agent_list_identities
  echo "------------"
  find "$SSH_HOME"/ -type f -not -name '*.pub' -not -name 'known_*' -printf '%f\n' | fzf | xargs -o -I {} ssh-add "$SSH_HOME"/{}
}

alias ssh-agent-create=ssh_agent_create
alias sac=ssh_agent_activate_current
alias sal=ssh_agent_list_identities
alias saa=ssh_agent_add_identity
alias sas=ssh_agent_add_identities
alias sad=ssh_agent_remove_identity
