#! /bin/bash
## # fzf plugin
##
## Helper functions to work with fzf
##
## Installs fzf if is not available
## 
## Requires: rg (ripgrep) 

fzf () {
  ### Lazy loads fzf and installs it if not present
  unset -f fzf
  [ ! -d ~/.fzf ] \
    && echo "Cloning fzf repo" \
    && git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf \
    && $HOME/.fzf/install --no-update-rc
  [ -f ~/.fzf.zsh ] \
    && source ~/.fzf.zsh \
    && [[ $- == *i* ]] && source "/home/gmatheu/.fzf/shell/completion.zsh" 2> /dev/null \
    && source "/home/gmatheu/.fzf/shell/key-bindings.zsh"
  fzf
}
cli-launcher () {
  ### Shows and launches gtk application
  application=$(echo $(find /usr/share/applications -name '*.desktop' -printf "%f\\\\n")\
$(find  /var/lib/snapd/desktop/applications -name '*.desktop' -printf "%f\\\\n")\
$(find ~/.local/share/applications -name '*.desktop' -printf "%f\\\\n") | \
              sed -e 's/.desktop//g' | sort | uniq | fzf)
  gtk-launch $application 2>&1 > /dev/null & disown
}
edit-fzf () {
  ### Shows fzf and opens selected file with default editor
  selected=$(fzf)
  print -s "$EDITOR ${selected}"
  $EDITOR ${selected}
}
grep-fzf () {
  ### Search content, fuzzy search and opens selected file with default editor
  selected=$(rg -L --color=never --no-heading --with-filename --line-number --column --smart-case . | fzf)
  filename=$(echo $selected | cut -d : -f 1)
  print -s "$EDITOR ${filename}"
  $EDITOR ${filename}
}
cd-z () {
  ### Finds z registered directories and changes directory. 
  selected=$(z | fzf)
  directory=$(echo $selected | tr -s ' ' | cut -d ' ' -f 2)
  print -s "cd ${directory}"
  builtin cd ${directory}
}

alias zz=cd-z
alias ez=edit-fzf
alias eg=grep-fzf
alias launcher=cli-launcher
alias cl=cli-launcher
