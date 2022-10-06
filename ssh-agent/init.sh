#! /bin/sh


SSH_AGENT_MUTEX=~/.current_ssh_agent
SSH_HOME=$HOME/.ssh

ssh-agent-create () {
  ssh-agent > $SSH_AGENT_MUTEX
}
ssh-agent-activate-current () {
  source $SSH_AGENT_MUTEX
}
ssh-agent-list-identities () {
  echo "> Loaded Entities"
  ssh-add -l
}
ssh-agent-add-identities () {
  ssh-agent-list-identities
  echo "------------"
  find $SSH_HOME -type f -not -name '*.pub' -not -name 'known_*' -printf '%f\n' | gum choose --no-limit | xargs -o -I {} ssh-add $SSH_HOME/{}
}

ssh-agent-add-identity () {
  ssh-agent-list-identities
  echo "------------"
  find $SSH_HOME/ -type f -not -name '*.pub' -not -name 'known_*' -printf '%f\n' | fzf | xargs -o -I {} ssh-add $SSH_HOME/{}
}
