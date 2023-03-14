#! /bin/bash
## # fzf plugin
##
## Helper functions to work with fzf
##
## Instals fzf if is not available

fzf () {
  ### Lazy loads fzf and installs it if not present
  unset -f fzf
  [ ! -d ~/.fzf ] \
    && echo "Cloning fzf repo" \
    && git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf \
    && $HOME/.fzf/install --no-update-rc
  [ -f ~/.fzf.zsh ] \
    && source ~/.fzf.zsh
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

alias ez=edit-fzf
alias launcher=cli-launcher
alias cl=cli-launcher
