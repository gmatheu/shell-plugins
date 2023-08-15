#! /bin/bash
### # tmux plugins
##
## Several functions to help with tmux integration
##
## Requires: 
##    * tmux (and a tmux session)
##    * fzf to provide fuzzy search

tmux_pane_pstree() { 
  ### Shows a ps tree from given window and pane
  ### 
  ### Parameters:
  ###  * 1: Window id
  ###  * 2: Pane id
  window=$1; 
  pane=$2;
  tmux list-panes -t "$window" -f "#{?#{m:$pane,#{pane_id}},1,0}" -F '#{pane_pid}' |\
    xargs -I{} bash -c 'pstree -a -p -T $0' {};
}

tmux_pstree(){
  ### Shows a ps tree all tmux session
  for pane in $(tmux list-windows -F '#{window_id}' | xargs -I {} tmux list-panes -t {} -F "#{window_id}:#{pane_id}");
  do 
    pane_id=$(echo "${pane}" | cut -d ':' -f 2);
    w_id=$(echo "${pane}" | cut -d ':' -f 1);
    echo -n "- ${w_id}.${pane_id} -> "
    tmux_pane_pstree "${w_id}" "${pane_id}";
  done

}

tmux_execute_inactive_pane () {
  ### Executes command into a non-active pane of the same window
  ### 
  ### Parameters:
  ###  * 1: command to execute
  cmd="$*"
  tmux send-keys -t $(tmux list-panes -f '#{?pane_active,0,1}' -F '#{pane_id}') "${cmd}" Enter
}

tmux_repeat_inactive_pane () {
  ### Executes last command from history in a non-active pane
  ### 
  tmux_execute_inactive_pane '!!'
}

tmux_execute_inactive_pane_interactive () {
  ### Executes command from interactive input into a non-active pane of the same window
  echo -n "Command: ";
  read -r cmd;
  tmux_execute_inactive_pane "${cmd}"
}

tmux_execute_inactive_pane_command_prompt () {
  ### Executes command from tmux's command-prompt into a non-active pane of the same window
  tmux command-prompt -p 'Command: ' "send-keys '%1' Enter";
  read -r cmd; 
  tmux_execute_inactive_pane "${cmd}"
}

alias txc='tmux show-buffer | xc' #Put Tmux buffer in the clipboard
alias txps=tmux_pstree
alias txr=tmux_execute_alt_pane 
alias txri=tmux_execute_inactive_pane_interactive 
alias txr=tmux_repeat_inactive_pane
alias txe=tmux_execute_inactive_pane
alias txrp=tmux_execute_inactive_pane_command_prompt
