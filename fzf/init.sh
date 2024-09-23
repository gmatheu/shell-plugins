#! /bin/bash
## # fzf plugin
##
## Helper functions to work with fzf
##
## Installs fzf if is not available
##
## Requires: rg (ripgrep)

__load_fzf() {
	type fzf >/dev/null | grep -q 'function' && unset -f fzf
	[ ! -d ~/.fzf ] &&
		echo "Cloning fzf repo" &&
		git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf &&
		$HOME/.fzf/install --no-update-rc
	[ -f ~/.fzf.zsh ] &&
		source ~/.fzf.zsh
	# [[ $- == *i* ]] && source "${HOME}/.fzf/shell/completion.zsh" 2>/dev/null &&
	# source "${HOME}/.fzf/shell/key-bindings.zsh"
}

fzf() {
	### Lazy loads fzf and installs it if not present.
	### Keeps ctrl-r bindkey to what it was before
	prev_ctrl_bind=$(bindkey "^R" | cut -d ' ' -f 2)
	__load_fzf
	bindkey "^R" "${prev_ctrl_bind}"
	fzf "$@"
}
zi() {
	__load_fzf
	__zoxide_zi "$@"
}
cli-launcher() {
	### Shows and launches gtk application
	application=$(echo $(find /usr/share/applications -name '*.desktop' -printf "%f\\\\n")$(find /var/lib/snapd/desktop/applications -name '*.desktop' -printf "%f\\\\n")$(find ~/.local/share/applications -name '*.desktop' -printf "%f\\\\n") |
		sed -e 's/.desktop//g' | sort | uniq | fzf)
	gtk-launch $application 2>&1 >/dev/null &
	disown
}
edit-fzf() {
	### Shows fzf and opens selected file with default editor
	query=${1:-''}
	selected=$(fzf --preview 'cat {}' -q "${query}")
	ret=$?
	[ ${ret} -eq 0 ] && {
		print -s "$EDITOR ${selected}"
		where atuin 1>/dev/null 2>&1 && atuin history start "$EDITOR ${selected}"
		$EDITOR "${selected}"
	}
}
grep-fzf() {
	### Search content, fuzzy search and opens selected file with default editor
	selected=$(rg -L --color=never --no-heading --with-filename --line-number --column --smart-case . | fzf)
	ret=$?
	filename=$(echo $selected | cut -d : -f 1)
	[ ${ret} -eq 0 ] && {
		print -s "$EDITOR ${filename}"
		where atuin 1>/dev/null 2>&1 && atuin history start "$EDITOR ${selected}"
		$EDITOR ${filename}
	}
}
open-fzf() {
	### Open files with default app selected file
	###
	### Argumetns: base-directory
	selected=$(find $1 -type f -print | fzf)
	print -s "xdg-open ${selected}"
	xdg-open ${selected}
}
open-dir-fzf() {
	### Open directories with default file browser
	###
	### Argumetns: base-directory
	selected=$(find $1 -type d -print | fzf)
	print -s "xdg-open ${selected}"
	xdg-open ${selected}
}
cd-z() {
	### Finds zoxide or z registered directories and changes directory.
	which zoxide &>/dev/null && {
		selected=$(zoxide query -l | fzf)
		directory=$(echo $selected | tr -s ' ' | cut -d ' ' -f 2)
	} || {
		selected=$(z | fzf)
		directory=$(echo $selected | tr -s ' ' | cut -d ' ' -f 2)
	}
	print -s "cd ${directory}"
	builtin cd ${directory}
}

alias zo=open-fzf
alias zd=open-dir-fzf
alias zz=cd-z
alias ez=edit-fzf
alias eg=grep-fzf
alias launcher=cli-launcher
alias cl=cli-launcher
