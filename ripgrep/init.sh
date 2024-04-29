#! /bin/bash
### # ripgrep plugins
##
## Several functions to help with ripgrep integration
##
##
## Requires:
##
##    * rg (ripgrep)
##    * fzf to provide fuzzy search

rg_ignore_candidates() {
	### Shows file count by extension (.ignore file friendly)
	###
	### Parameters:
	###  * 1: directory, by default git root or current if not in a git repository
	default_directory=$(git rev-parse --show-toplevel)
	directory=${1:-${default_directory}}
	find "${directory}" -printf '%f\n' -not -path '*.git*' |
		grep -o -e '\..*' - |
		sort |
		uniq -c |
		sort -h -r |
		awk '{print $2 " # filecount: " $1}'
}

alias rg_ignore_candidates_pwd='rb_ignore_candidates "$(pwd)"'
alias rg_ignore='rg_ignore_candidates | head -n 3 | tee -a .ignore'
alias rg_ignore_pwd='rg_ignore_candidates "$(pwd)" | head -n 3 | tee -a .ignore'
