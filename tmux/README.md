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

### tmux_popup_session
   Creates a auxiliary tmux session (${TMUX_POPUP_SESSION})

### tmux_popup_window
   Creates a new window into auxiliary tmux session (${TMUX_POPUP_SESSION}) with given name.

   Parameters:
    * 1: Window name

### tmux_display_popup
   Shows a popup windows using and secondary tmux session (it is created if it is does not exist)

### tmux_popup
   Executes a coomand into a popup window using and secondary tmux session (it is created if it is does not exist)

   Parameters:
    * 1: command to execute
    * 2: target windows name. By default, it uses ${TMUX_POPUP_DEFAULT_WINDOW}

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
