# # tmux plugins

 Several functions to help with tmux integration

 Requires: 
    * tmux (and a tmux session)
    * fzf to provide fuzzy search


## Functions

### tmux_pane_pstree 
   Shows a ps tree from given window and pane
   
   Parameters:
    * 1: Window id
    * 2: Pane id

### tmux_pstree
   Shows a ps tree all tmux session

### tmux_execute_inactive_pane 
   Executes command into a non-active pane of the same window
   
   Parameters:
    * 1: command to execute

### tmux_repeat_inactive_pane 
   Executes last command from history in a non-active pane
   

### tmux_execute_inactive_pane_interactive 
   Executes command from interactive input into a non-active pane of the same window

### tmux_execute_inactive_pane_command_prompt 
   Executes command from tmux's command-prompt into a non-active pane of the same window


## Aliases

* *txc*: 'tmux show-buffer | xc' #Put Tmux buffer in the clipboard
* *txps*: tmux_pstree
* *txr*: tmux_execute_alt_pane 
* *txri*: tmux_execute_inactive_pane_interactive 
* *txr*: tmux_repeat_inactive_pane
* *txe*: tmux_execute_inactive_pane
* *txrp*: tmux_execute_inactive_pane_command_prompt
