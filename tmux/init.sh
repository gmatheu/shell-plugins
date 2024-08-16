#! /bin/bash
### # tmux plugins
##
## Several functions to help with tmux integration
##
## ## Demos
##
## * [tmux_popup](recordings/TmuxShellPlugin.webm)
##
## Requires:
##
##    * tmux (and a tmux session)
##    * fzf to provide fuzzy search

tmux_pane_pstree() {
	### Shows a ps tree from given window and pane
	###
	### Parameters:
	###  * 1: Window id
	###  * 2: Pane id
	window=$1
	pane=$2
	tmux list-panes -t "$window" -f "#{?#{m:$pane,#{pane_id}},1,0}" -F '#{pane_pid}' |
		xargs -I{} bash -c 'pstree -a -p -T $0' {}
}

TMUX_POPUP_SESSION=${TMUX_POPUP_SESSION:-popup}
TMUX_POPUP_DEFAULT_WINDOW=${TMUX_POPUP_DEFAULT_WINDOW:-scratch}
tmux_popup_session() {
	### Creates a auxiliary tmux session (${TMUX_POPUP_SESSION})
	tmux new-session -Ad -s "${TMUX_POPUP_SESSION}" 2>/dev/null &&
		tmux rename-window -t "${TMUX_POPUP_SESSION}" "${TMUX_POPUP_DEFAULT_WINDOW}"
}

tmux_popup_window() {
	### Creates a new window into auxiliary tmux session (${TMUX_POPUP_SESSION}) with given name.
	###
	### Parameters:
	###  * 1: Window name

	window="$1"
	tmux_popup_session
	tmux select-window -t "${TMUX_POPUP_SESSION}:${window}" 2>/dev/null ||
		{
			tmux new-window -t "${TMUX_POPUP_SESSION}" zsh
			tmux rename-window -t "${TMUX_POPUP_SESSION}" "${window}"
			tmux select-window -t "${TMUX_POPUP_SESSION}:${window}"
		}
}

tmux_display_popup() {
	### Shows a popup windows using and secondary tmux session (it is created if it is does not exist)

	tmux_popup_session
	tmux display-pop -x 2000 -y 0 -h "95%" "tmux attach -t ${TMUX_POPUP_SESSION};"
}

tmux_popup() {
	### Executes a coomand into a popup window using and secondary tmux session (it is created if it is does not exist)
	###
	### Parameters:
	###  * 1: command to execute
	###  * 2: target windows name. By default, it uses ${TMUX_POPUP_DEFAULT_WINDOW}

	cmd="$1"
	window=${2:-${TMUX_POPUP_DEFAULT_WINDOW}}
	tmux_popup_window "${window}"
	tmux send-keys -t "${TMUX_POPUP_SESSION}:${window}" Enter "${cmd}" Enter
	tmux select-window -t "${TMUX_POPUP_SESSION}:${window}"
	tmux_display_popup
}

tmux_pstree() {
	### Shows a ps tree all tmux session
	for pane in $(tmux list-windows -F '#{window_id}' | xargs -I {} tmux list-panes -t {} -F "#{window_id}:#{pane_id}"); do
		pane_id=$(echo "${pane}" | cut -d ':' -f 2)
		w_id=$(echo "${pane}" | cut -d ':' -f 1)
		echo -n "- ${w_id}.${pane_id} -> "
		tmux_pane_pstree "${w_id}" "${pane_id}"
	done

}

tmux_execute_inactive_pane() {
	### Executes command into a non-active pane of the same window
	###
	### Parameters:
	###  * 1: command to execute
	cmd="$*"
	target_pane=$(tmux list-panes -f '#{?pane_active,0,#{?#{==:#{pane_current_command},zsh},1,0}}' -F '#{pane_id}' | head -n 1)
	tmux send-keys -t "${target_pane}" "${cmd}" Enter
}

tmux_repeat_inactive_pane() {
	### Executes last command from history in a non-active pane
	###
	tmux_execute_inactive_pane '!!'
}

tmux_execute_inactive_pane_interactive() {
	### Executes command from interactive input into a non-active pane of the same window
	echo -n "Command: "
	read -r cmd
	tmux_execute_inactive_pane "${cmd}"
}

tmux_execute_inactive_pane_command_prompt() {
	### Executes command from tmux's command-prompt into a non-active pane of the same window
	tmux command-prompt -p 'Command: ' "send-keys '%1' Enter"
	read -r cmd
	tmux_execute_inactive_pane "${cmd}"
}

alias txc='tmux show-buffer | xc' #Put Tmux buffer in the clipboard
alias txps=tmux_pstree
alias txr=tmux_execute_alt_pane
alias txri=tmux_execute_inactive_pane_interactive
alias txr=tmux_repeat_inactive_pane
alias txe=tmux_execute_inactive_pane
alias txrp=tmux_execute_inactive_pane_command_prompt
